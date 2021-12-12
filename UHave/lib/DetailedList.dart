import 'package:flutter/material.dart';
import 'package:uhave_project/services/detailedlist_service.dart';

import 'modules/detailedList.dart';

class DetailedList extends StatefulWidget{

  late String tarih;
  late int categoryId;

  DetailedList({required this.categoryId,required this.tarih});

  @override
  _DetailedListState createState() => _DetailedListState(categoryId,tarih);

}

class _DetailedListState extends State<DetailedList>{

  late int categoryId;

  late String tarih;

  _DetailedListState(this.categoryId,this.tarih);

  var _detailedListList;

  var detailedLists;

  var detailedListe;

  var _DetailedListService = DetailedListService();

  var _detailedList = detailedList();// detailed listin bir nesnesi verileri tutmak için normal bir class nesnesi

  var _detailedListKonuController = TextEditingController();

  var _detailedListAciklamaController = TextEditingController();

  var _detailedListTarihController = TextEditingController();

  @override
  void initState(){
    super.initState();
    getAllData(this.categoryId,this.tarih);
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllData(int categoryId,String tarih) async{
    _detailedListList = <detailedList>[];
    var detailedLists = await _DetailedListService.readDetailedList(categoryId,tarih);
    detailedLists.forEach((detailedListe){
      setState(() {
        var detailedListModel = detailedList();// detailed listin bir nesnesi verileri tutmak için normal bir class nesnesi
        detailedListModel.id = detailedListe['id'];
        detailedListModel.konu = detailedListe['konu'];
        detailedListModel.aciklama = detailedListe['aciklama'];
        detailedListModel.tarih = detailedListe['tarih'];
        _detailedListList.add(detailedListModel);
      });
    });
  }

  _showFormDialog(BuildContext context){
    return showDialog(context: context,barrierDismissible: true,builder: (param){
      return AlertDialog(
        actions:<Widget>[
          FlatButton(
              color: Colors.red,
              onPressed: ()=>Navigator.pop(context),
              child: Text('Cancel')),
          FlatButton(
              color: Colors.green,
              onPressed: () async {
                _detailedList.konu=_detailedListKonuController.text;
                _detailedList.aciklama=_detailedListAciklamaController.text;
                _detailedList.categoryId = this.categoryId;
                _detailedList.tarih= this.tarih;
                _DetailedListService.saveDetailedList(_detailedList).then((id) => print("detailed list Id that was loaded: $id"));
                getAllData(this.categoryId,this.tarih);
                Navigator.pop(context);
              },
              child: Text('Save')),
        ],
        title: Text("Add New Category"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _detailedListKonuController,
                decoration: InputDecoration(
                    hintText: 'Enter a category name',
                    labelText: 'Category Name'
                ),
              ),
              TextField(
                controller: _detailedListAciklamaController,
                decoration: InputDecoration(
                    hintText: 'Enter a category name',
                    labelText: 'Category Name'
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: ListView.builder(
          itemCount:_detailedListList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8.0,
              child: ListTile(
                leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: (){
                      var id = _detailedListList[index].id;
                      //print("the current id is: $id");
                      //_editCategory(context, _categoryList[index].id);
                    }),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_detailedListList[index].konu!),
                    IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: (){
                          //_deleteFormDialog(context, _categoryList[index].id);
                        }),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}