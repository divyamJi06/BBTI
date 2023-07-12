import 'package:bbti/bottom_nav_bar.dart';
import 'package:bbti/controllers/storage.dart';
import 'package:bbti/models/contacts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_range/time_range.dart';

class AccessRequestPage extends StatefulWidget {
  AccessRequestPage({required this.name, super.key});
  final String name;
  static List<String> items = [
    'Full Time Access',
    'One Time Access',
    'Timed Access',
  ];

  @override
  State<AccessRequestPage> createState() => _AccessRequestPageState();
}

class _AccessRequestPageState extends State<AccessRequestPage> {
  String dropdownvalue = "Full Time Access";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime dateTime = DateTime.now();
  bool showDate = false;
  bool showTime = false;
  bool showDateTime = false;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  bool completed = false;

  // Select for Date
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

// Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }
  // select date time picker

  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    if (date == null) return;

    final time = await _selectTime(context);

    if (time == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  String getDate() {
    // ignore: unnecessary_null_comparison
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('MMM d, yyyy').format(selectedDate);
    }
  }

  String getDateTime() {
    // ignore: unnecessary_null_comparison
    if (dateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('yyyy-MM-dd HH: ss a').format(dateTime);
    }
  }

  String getTime(TimeOfDay tod) {
    final now = DateTime.now();

    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ARP"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.name),
            DropdownButton<String>(
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: AccessRequestPage.items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
                // if (dropdownvalue == "Timed Access") {
                //   _selectDateTime(context);
                //   print(getDateTime());
                // }
              },
            ),
            dropdownvalue == "Timed Access" ? selectDateTime() : Container(),
            dropdownvalue == "Timed Access"
                ? TimeRange(
                    fromTitle: Text(
                      'From',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    toTitle: Text(
                      'To',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    titlePadding: 20,
                    textStyle: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black87),
                    activeTextStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    borderColor: Colors.black,
                    backgroundColor: Colors.transparent,
                    activeBackgroundColor: Colors.black38,
                    firstTime: TimeOfDay(hour: 14, minute: 30),
                    lastTime: TimeOfDay(hour: 20, minute: 00),
                    timeStep: 10,
                    timeBlock: 30,
                    onRangeCompleted: (range) => setState(() {
                      startTime = range!.start;
                      endTime = range!.end;
                      completed = true;
                    }),
                  )
                : Container(),
            completed
                ? Text(startTime.hour.toString() +
                    ":" +
                    startTime.minute.toString() +
                    " - " +
                    endTime.hour.toString() +
                    ":" +
                    endTime.minute.toString())
                : Container(),
            ElevatedButton(
                onPressed: () {
                  String time = "00:00-00:00";
                  String date = "00-00";
                  if (dropdownvalue == "Timed Access") {
                    time = startTime.hour.toString() +
                        ":" +
                        startTime.minute.toString() +
                        "-" +
                        endTime.hour.toString() +
                        ":" +
                        endTime.minute.toString();
                    date = "12-24";
                  } else {}
                  StorageController _storage = new StorageController();
                  _storage.addContacts(ContactsModel(
                      accessType: dropdownvalue,
                      date: date,
                      time: time,
                      name: widget.name));

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyNavigationBar()));
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }

  Widget selectDateTime() {
    return DateRangeWidget();
  }
}

class DateRangeWidget extends StatefulWidget {
  DateRangeWidget({Key? key}) : super(key: key);

  @override
  State<DateRangeWidget> createState() => _DateRangeWidgetState();
}

class _DateRangeWidgetState extends State<DateRangeWidget> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2021, 11, 5),
    end: DateTime(2022, 12, 10),
  );
  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

    return Column(children: [
      const Text(
        'Date Range',
        style: TextStyle(fontSize: 16),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: ElevatedButton(
              child: Text(
                '${start.year}/${start.month}/${start.day}',
              ),
              onPressed: pickDateRange,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: ElevatedButton(
              child: Text(
                '${end.year}/${end.month}/${end.day}',
              ),
              onPressed: pickDateRange,
            ),
          ),
        ],
      )
    ]);
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
    );
    setState(() {
      dateRange = newDateRange ?? dateRange;

      // if (newDateRange == null) return;
      // setState(() => dateRange = newDateRange);
    });
  }
}
