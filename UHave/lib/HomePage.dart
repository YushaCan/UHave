import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uhave_project/modules/category.dart';
import 'package:uhave_project/services/category_service.dart';
import 'package:uhave_project/services/notification.dart';
import 'Calendar.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _categoryNameController = TextEditingController();

  var _editCategoryNameController = TextEditingController();

  var _category = Category();

  var category;

  var _categoryService = CategoryService();

  var _categoryList = <Category>[];

  @override
  void initState() {
    Provider.of<NotificationService>(context, listen: false).initialize();
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = <Category>[];
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.id = category['id'];
        categoryModel.name = category['name'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoriesById(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]['name'] ?? 'No Name';
    });
    _editFormDialog(context);
  }

  _showFormDialog(BuildContext context) {
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
                  child: Text('Cancel',style: TextStyle(color: Colors.black),)),
              FlatButton(
                  color: Colors.purple[50],
                  onPressed: () async {
                    _category.name = _categoryNameController.text;
                    _categoryService
                        .saveCategory(_category)
                        .then((id) => print("Id that was loaded: $id"));
                    getAllCategories();
                    Navigator.pop(context);
                  },
                  child: Text('Save',style: TextStyle(color: Colors.black),)),
            ],
            title: Text("Add New Category"),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Enter a category name',
                        labelText: 'Category Name'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editFormDialog(BuildContext context) {
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
                  child: Text('Cancel',style: TextStyle(color: Colors.black),)),
              FlatButton(
                  color: Colors.purple[50],
                  onPressed: () async {
                    _category.id = category[0]['id'];
                    _category.name = _editCategoryNameController.text;
                    _categoryService
                        .updateCategory(_category)
                        .then((id) => print("Id that was loaded: $id"));
                    Navigator.pop(context);
                    getAllCategories();
                    _showSuccessSnackBar(Text('Updated!'));
                  },
                  child: Text('Update',style: TextStyle(color: Colors.black),)),
            ],
            title: Text("Edit Category"),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _editCategoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Enter a category name',
                        labelText: 'Category Name'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
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
                  child: Text('Cancel',style: TextStyle(color: Colors.black),)
              ),
              FlatButton(
                  color: Colors.purple[50],
                  onPressed: () async {
                    _categoryService
                        .deleteCategory(categoryId)
                        .then((id) => print("Id that was loaded: $id"));
                    Navigator.pop(context);
                    getAllCategories();
                    _showSuccessSnackBar(Text('Deleted!'));
                  },
                  child: Text('Delete',style: TextStyle(color: Colors.black),)),
            ],
            title: Text("Are you sure?",style: TextStyle(color: Colors.white),),
          );
        });
  }

  _showSuccessSnackBar(message) {
    var _snackbar = SnackBar(content: message);
    _globalKey.currentState!.showSnackBar(_snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(
            "Categories",
            textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8.0,
              color: Colors.indigo[300],
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => Calendar(
                            categoryId: _categoryList[index].id!)));
                  },
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                          _categoryList[index].name!,
                      style: TextStyle(
                        color: Colors.white,
                          fontStyle: FontStyle.italic,
                        fontSize: 20,
                      ),
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.white,
                              onPressed: () {
                                _deleteFormDialog(context, _categoryList[index].id);
                              }),
                          IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.white,
                              onPressed: () {
                                _editCategory(context, _categoryList[index].id);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
      ),
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
