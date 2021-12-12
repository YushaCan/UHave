import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'DetailedList.dart';

class Calendar extends StatefulWidget{

  late int categoryId;

  Calendar({required this.categoryId});

  @override
  State<Calendar> createState() => _CalendarState(categoryId);
}

class _CalendarState extends State<Calendar> {

  late int categoryId;

  _CalendarState(this.categoryId);
  CalendarFormat format= CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar "),
        centerTitle: true,
      ),
      body: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(1990),
        lastDay: DateTime(2050),
        calendarFormat: format,
        onFormatChanged: (CalendarFormat _format){
          setState(() {
            format = _format;
          });
        },

        startingDayOfWeek: StartingDayOfWeek.sunday,
        daysOfWeekVisible: true,
        //day changed
        onDaySelected: (DateTime selectDay, DateTime focusDay){
          setState(() {
            selectedDay = selectDay;
            focusedDay = focusDay;
            print(selectedDay);
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailedList(categoryId: this.categoryId,tarih: selectedDay.toString())));
          });

        },
        //to style the calendar
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
        ),
        selectedDayPredicate: (DateTime date){
          return isSameDay(selectedDay, date);
        },
      ),
    );
  }
}
