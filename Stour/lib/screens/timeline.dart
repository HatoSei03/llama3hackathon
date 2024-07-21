import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:stour/screens/timeline_screen.dart';
import 'package:intl/intl.dart';
import 'package:stour/util/const.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});
  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  DateTime _departureDate = DateTime.now();
  DateTime _returnDate = DateTime.now();
  double _maxBudget = 0;
  bool _isTravelingAlone = true;
  TimeOfDay _startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 0, minute: 0);
  int _travellerNum = 1;

  void _generateSchedule() {
    {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleScreen(
            departureDate: _departureDate,
            returnDate: _returnDate,
            maxBudget: _maxBudget,
            isTravelingAlone: _isTravelingAlone,
            startTime: _startTime,
            endTime: _endTime,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    _departureDate = DateTime.now();
    _returnDate = DateTime.now();
    _maxBudget = 0;
    _startTime = const TimeOfDay(hour: 0, minute: 0);
    _endTime = const TimeOfDay(hour: 0, minute: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.palette3,
        title: Text('Initerary Planning',
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: Constants.paletteDark,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Departure Date',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Constants.paletteDark,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _departureDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              _departureDate = picked;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.palette3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: Icon(
                          CupertinoIcons.calendar,
                          color: Constants.paletteDark,
                        ),
                        label: Text(
                          DateFormat('dd/MM/yyyy').format(_departureDate),
                          style: TextStyle(color: Constants.paletteDark),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(width: 30),
                  const Spacer(),
                  Column(
                    children: [
                      Text('Return Date',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Constants.paletteDark)),
                      const SizedBox(height: 8.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _returnDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              _returnDate = picked;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.palette3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: Icon(
                          CupertinoIcons.calendar,
                          color: Constants.paletteDark,
                        ),
                        label: Text(
                          DateFormat('dd/MM/yyyy').format(_returnDate),
                          style: TextStyle(color: Constants.paletteDark),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                'Budget (VND)',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Constants.paletteDark),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  setState(() {
                    _maxBudget = double.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your budget',
                  prefixIcon: Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Constants.paletteDark,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Traveling Alone?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Constants.paletteDark),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Radio(
                    value: true,
                    activeColor: Constants.paletteDark,
                    groupValue: _isTravelingAlone,
                    onChanged: (value) {
                      setState(() {
                        _isTravelingAlone = value ?? false;
                      });
                    },
                  ),
                  Text('Yes',
                      style: TextStyle(
                          color: Constants.paletteDark,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(width: 16.0),
                  Radio(
                    value: false,
                    activeColor: Constants.palette2,
                    groupValue: _isTravelingAlone,
                    onChanged: (value) {
                      setState(() {
                        _isTravelingAlone = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    'No',
                    style: TextStyle(
                      color: Color.fromARGB(255, 35, 52, 10),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              if (!_isTravelingAlone)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      setState(() {
                        _travellerNum = int.tryParse(value) ?? 1;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter number of travelers',
                      prefixIcon: Icon(
                        Icons.group,
                        color: Constants.paletteDark,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Column(
                    children: [
                      Text('Start of Day',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Constants.paletteDark)),
                      const SizedBox(height: 2.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: _startTime,
                          );
                          if (picked != null) {
                            setState(() {
                              _startTime = picked;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.palette3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(
                          CupertinoIcons.clock,
                          color: Color.fromARGB(255, 64, 64, 63),
                        ),
                        label: Text(
                          _startTime.format(context),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        'End of Day',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Constants.paletteDark),
                      ),
                      const SizedBox(height: 2.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: _endTime,
                          );
                          if (picked != null) {
                            setState(() {
                              _endTime = picked;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.palette3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(
                          CupertinoIcons.clock,
                          color: Color.fromARGB(255, 64, 64, 63),
                        ),
                        label: Text(
                          _endTime.format(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              Center(
                child: ElevatedButton(
                  onPressed: _generateSchedule,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4E7C5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Start Planning',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 35, 52, 10)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
