// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import 'HandlingDataView.dart';
import 'core/class/statusrequest.dart';
import 'core/common/booking_dataTime_converted.dart';
import 'core/common/button.dart';
import 'featuers/play/controller/play_controller.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final String? collection;
  final String? groundId;
  final String? groundImage;
  final Color? color;
  final int? playersMaxNum;
  const BookingScreen(
      {this.collection,
      this.groundId,
      this.color,
      this.playersMaxNum,
      this.groundImage});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _dateSelected = false;
  bool _timeSelected = false;
  List<String> timeRanges = [
    "12:00 PM - 1:00 PM"
        "1:00 PM - 2:00 PM",
    "2:00 PM - 3:00 PM",
    "3:00 PM - 4:00 PM",
    "4:00 PM - 5:00 PM",
    "5:00 PM - 6:00 PM",
    "6:00 PM - 7:00 PM",
    "7:00 PM - 8:00 PM",
    "8:00 PM - 9:00 PM",
    "9:00 PM - 10:00 PM",
    "10:00 PM - 11:00 PM",
    "11:00 PM - 12:00 AM",
    "12:00 AM - 1:00 AM",
    "1:00 AM - 2:00 AM",
    "2:00 AM - 3:00 AM",
    "3:00 AM - 4:00 AM",
    "4:00 AM - 5:00 AM",
    "5:00 AM - 6:00 AM",
    "6:00 AM - 7:00 AM",
    "7:00 AM - 8:00 AM",
    "8:00 AM - 9:00 AM",
    "9:00 AM - 10:00 AM",
    "10:00 AM - 11:00 AM",
    "11:00 AM - 12:00 PM"
  ];

  void setReservision(
      WidgetRef ref, BuildContext context, String time, String day) {
    ref.watch(playControllerProvider.notifier).setResrvision(
        widget.groundId!,
        context,
        widget.collection!,
        widget.playersMaxNum!,
        time,
        day,
        widget.groundImage!,
        "");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    StatusRequest statusRequest = ref.watch(playControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "booking",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: HandlingDataView(
          statusRequest: statusRequest,
          widget: Padding(
            padding: EdgeInsets.all(size.width * 0.03),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _tableCalender(),
                      Center(
                        child: Text(
                          "Select Reservision Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            _timeSelected = true;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _currentIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: _currentIndex == index ? widget.color : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${timeRanges[index]}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  _currentIndex == index ? Colors.white : null,
                            ),
                          ),
                        ),
                      );
                    }, childCount: timeRanges.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 1.5)),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 80),
                    child: Button(
                      color: widget.color!,
                      width: double.infinity,
                      title: 'Make Appointment',
                      onPressed: () async {
                        final day = DateConverted.getDate(_currentDay);
                        final time = DateConverted.getTime(_currentIndex!);

                        setReservision(ref, context, time, day);
                      },
                      disable: _timeSelected && _dateSelected ? false : true,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _tableCalender() {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2024, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      calendarStyle: CalendarStyle(
        todayDecoration:
            BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {CalendarFormat.month: "Month"},
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusedDay = focusedDay;
          _dateSelected = true;
        });
      },
    );
  }
}
