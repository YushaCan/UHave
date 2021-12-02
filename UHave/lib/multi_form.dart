import 'package:flutter/material.dart';
import 'package:uhave_project/modules/category.dart';

import 'form.dart';

class MultiForm extends StatefulWidget{
  @override
_MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm>{
  List<category> categories = [];
  List<CategoryForm> forms = [];
  @override
  Widget build(BuildContext context){
    forms.clear();
    for(int i=0; i<categories.length; i++){
      forms.add(CategoryForm(
        new_category: categories[i],
        onDelete: () => onDelete(i),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: <Widget>[
          FlatButton(child: Text('Save'),
            onPressed: (){},
          )],
      ),
      body: categories.length<=0 ? Center(
        child: Text('Add form by tapping [+] button below'),
      ): ListView.builder(
        itemCount: categories.length,
        itemBuilder: (_, i)=> forms[i],),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
      ),
    );
  }

  void onDelete(int index){
    setState(() {
      categories.removeAt(index);
    });
  }

  void onAddForm(){
    setState((){
      categories.add(category(category_name: ''));
    });
  }

  void onSave(){
    forms.forEach((form) =>form);
  }
}