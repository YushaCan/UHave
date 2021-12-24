import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uhave_project/services/detailedlist_service.dart';
import 'package:uhave_project/services/notification.dart';
import 'modules/detailedList.dart';

class DetailedList extends StatefulWidget {
  late String tarih;
  late int categoryId;

  DetailedList({required this.categoryId, required this.tarih});

  @override
  _DetailedListState createState() => _DetailedListState(categoryId, tarih);
}

class _DetailedListState extends State<DetailedList> {
  late int categoryId;

  late String tarih;

  _DetailedListState(this.categoryId, this.tarih);

  var _detailedListList;

  var detailedLists;

  var detailedListe;

  var detailedlist;

  var _DetailedListService = DetailedListService();

  var _detailedList =
      detailedList(); // detailed listin bir nesnesi verileri tutmak için normal bir class nesnesi

  var _detailedListKonuController = TextEditingController();

  var _detailedListAciklamaController = TextEditingController();

  var _editDetailedListNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getAllData(this.categoryId, this.tarih);
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

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

  _showFormDialog(BuildContext context) {
    bool isPressed = false;
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            backgroundColor: Colors.indigo[200],
            actions: <Widget>[
              Consumer<NotificationService>(
                  builder: (context, model, _) => Row(
                        children: [
                          FlatButton(
                              color: Colors.pink[50],
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black),
                              )),
                          FlatButton(
                              color: Colors.pink[50],
                              onPressed: () async {
                                _detailedList.konu =
                                    _detailedListKonuController.text;
                                _detailedList.aciklama =
                                    _detailedListAciklamaController.text;
                                _detailedList.categoryId = this.categoryId;
                                _detailedList.tarih = this.tarih;
                                _DetailedListService.saveDetailedList(
                                        _detailedList)
                                    .then((id) => print(
                                        "detailed list Id that was loaded: $id"));
                                if (isPressed == true) {
                                  model.instantNotification(this.tarih);
                                }
                                getAllData(this.categoryId, this.tarih);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.black),
                              )),
                        ],
                      )),
            ],
            title: Text(
              "Add New Category",
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _detailedListKonuController,
                    decoration: InputDecoration(
                        hintText: 'Enter a subject name',
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: 'Subject',
                        labelStyle: TextStyle(color: Colors.white)),
                  ),
                  TextField(
                    controller: _detailedListAciklamaController,
                    decoration: InputDecoration(
                        hintText: 'Enter description',
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.white)),
                  ),
                  IconButton(
                    onPressed: () {
                      isPressed = true;
                    },
                    icon: Icon(Icons.alarm),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, detailedListId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            backgroundColor: Colors.indigo[200],
            actions: <Widget>[
              FlatButton(
                  color: Colors.purple[50],
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  )),
              FlatButton(
                  color: Colors.purple[50],
                  onPressed: () async {
                    _DetailedListService.deleteDetailedList(detailedListId)
                        .then((detailedListId) =>
                            print("Id that was loaded: $detailedListId"));
                    Navigator.pop(context);
                    getAllData(categoryId, tarih);
                    _showSuccessSnackBar(Text('Deleted!'));
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
            title: Text(
              "Are you sure?",
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }

  _showSuccessSnackBar(message) {
    var _snackbar = SnackBar(content: message);
    _globalKey.currentState!.showSnackBar(_snackbar);
  }

  _editFormDialog(BuildContext context, detailedListId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            backgroundColor: Colors.indigo[200],
            actions: <Widget>[
              FlatButton(
                  color: Colors.purple[50],
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  )),
              FlatButton(
                  color: Colors.purple[50],
                  onPressed: () async {
                    _detailedList.id = detailedListId;
                    _detailedList.konu = _detailedListKonuController.text;
                    _detailedList.aciklama =
                        _detailedListAciklamaController.text;
                    _DetailedListService.updateDetailedList(_detailedList);
                    Navigator.pop(context);
                    getAllData(categoryId, tarih);
                    _showSuccessSnackBar(Text('Updated!'));
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
            title: Text("Edit Category"),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _detailedListKonuController,
                    decoration: InputDecoration(
                        hintText: 'Enter a subject ', labelText: 'subject'),
                  ),
                  TextField(
                    controller: _detailedListAciklamaController,
                    decoration: InputDecoration(
                        hintText: 'Enter a description ',
                        labelText: 'description'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editDetailedList(BuildContext context, detailedListId) async {
    detailedlist =
        await _DetailedListService.readDetailedListById(detailedListId);
    setState(() {
      _editDetailedListNameController.text =
          detailedlist[0]['konu'] ?? 'No konu';
    });
    _editFormDialog(context, detailedListId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Event List"),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
          itemCount: _detailedListList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8.0,
              color: Colors.indigo[300],
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        Text(
                          _detailedListList[index].konu!,
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          _detailedListList[index].aciklama!,
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.white,
                            onPressed: () {
                              _deleteFormDialog(
                                  context, _detailedListList[index].id);
                            }),
                        IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.white,
                            onPressed: () {
                              _editDetailedList(
                                  context, _detailedListList[index].id);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
