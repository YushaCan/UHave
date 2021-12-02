import 'package:flutter/material.dart';
import 'package:uhave_project/Calendar.dart';
import 'package:uhave_project/modules/category.dart';
import 'modules/category.dart';

typedef OnDelete();

class CategoryForm extends StatefulWidget{
  late final category new_category;
  final state = _CategoryFormState();
  late final OnDelete onDelete;

  CategoryForm({required this.new_category, required this.onDelete});
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm>{
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(
                  Icons.people
                ),
                title: Text('New Category'),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      Calendar();
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.new_category.category_name,
                  onSaved: (val)=>widget.new_category.category_name = val!,
                  decoration: InputDecoration(
                    labelText: 'Category Name',
                    hintText: 'Enter category name',
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}