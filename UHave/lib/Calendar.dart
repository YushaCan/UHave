import 'dart:collection';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uhave_project/event.dart';
import 'DetailedList.dart';

class Calendar extends StatefulWidget {
  late int categoryId;

  Calendar({required this.categoryId});

  @override
  State<Calendar> createState() => _CalendarState(categoryId);
}

class _CalendarState extends State<Calendar> {
  late int categoryId;
  // To Hold Events
  late Map<DateTime, List<Event>> selectedEvents;

  _CalendarState(this.categoryId);
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  /////////////////////////////// PopUp Fonksiyonu ///////////////////////////////
  CreatePopUp(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Go Details?"),
            content: TextFormField(
              controller: _eventController,
            ),
            scrollable: true,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]!.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: _eventController.text)
                      ];
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
                child: Text("Ok"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar "),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            // When Select New Day =>
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailedList(
                        categoryId: this.categoryId,
                        tarih: selectedDay.toString())));
              });

              //PopUp Ekranı
              CreatePopUp(context);
            },
            // TO Get events
            eventLoader: _getEventsfromDay,

            //to style the calendar
            calendarStyle: CalendarStyle(
              markersAlignment: Alignment.bottomCenter,
              markersMaxCount: 5,
              markersOffset: const PositionedOffset(),
              markerDecoration: const BoxDecoration(
                color: const Color(0xFF263238),
                shape: BoxShape.circle,
              ),
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
            ),
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
          ),
          ..._getEventsfromDay(selectedDay).map(
            (Event event) => ListTile(
              title: Text(event.title),
            ),
          ),
        ],
      ),
    );
  }
}
