import 'dart:collection';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uhave_project/event.dart';
import 'DetailedList.dart';
import 'package:uhave_project/services/detailedlist_service.dart';
import 'modules/detailedList.dart';
import 'event.dart';

class Calendar extends StatefulWidget {
  late int categoryId;

  Calendar({required this.categoryId});

  @override
  State<Calendar> createState() => _CalendarState(categoryId);
}

class _CalendarState extends State<Calendar> {

  late int categoryId;

  var _detailedListList;

  var detailedLists;

  var detailedListe;

  var _DetailedListService = DetailedListService();

  var _detailedList = detailedList();

  // To Hold Events
  late Map<DateTime, List<Event>> selectedEvents;

  _CalendarState(this.categoryId);
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    getAllEvents(categoryId);
    super.initState();
  }

  getAllData(int categoryId, String tarih) async {

    _detailedListList = <detailedList>[];
    var detailedLists =
        await _DetailedListService.readDetailedList(categoryId, tarih);
    detailedLists.forEach((detailedListe) {
      setState(() {
        var detailedListModel =
            detailedList(); // detailed listin bir nesnesi verileri tutmak için normal bir class nesnesi
        detailedListModel.id = detailedListe['id'];
        detailedListModel.konu = detailedListe['konu'];
        detailedListModel.aciklama = detailedListe['aciklama'];
        detailedListModel.tarih = detailedListe['tarih'];
        _detailedListList.add(detailedListModel);
      });
    });
  }

  getAllEvents(int categoryId) async{
    _detailedListList = <detailedList>[];
    var detailedLists =
    await _DetailedListService.readAllDetailedList(categoryId);
    detailedLists.forEach((detailedListe) {
      setState(() {
        var detailedListModel =
        detailedList(); // detailed listin bir nesnesi verileri tutmak için normal bir class nesnesi
        detailedListModel.id = detailedListe['id'];
        detailedListModel.konu = detailedListe['konu'];
        detailedListModel.aciklama = detailedListe['aciklama'];
        detailedListModel.tarih = detailedListe['tarih'];
        _detailedListList.add(detailedListModel);
      });
    });
}


  @override
  void dispose() {
    super.dispose();
  }

  /////////////////////////////// PopUp Fonksiyonu ///////////////////////////////
  CreatePopUp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.indigo[200],
            title: Text("Go Details?",style: TextStyle(color: Colors.white)),
            content: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _detailedListList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8.0,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(_detailedListList[index].konu!),
                        ],
                      ),
                    ),
                  );
                }),
            scrollable: true,
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailedList(
                          categoryId: this.categoryId,
                          tarih: selectedDay.toString())));
                },
                child: Text("Go To Detailes",style: TextStyle(color: Colors.white)),
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
        backgroundColor: Colors.indigo,
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
              });
              getAllData(this.categoryId, selectedDay.toString());
              //PopUp Ekranı
              CreatePopUp(context);
            },
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
                color: Colors.indigo[600],
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
            ),
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
          ),
        ],
      ),
    );
  }
}
