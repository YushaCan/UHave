import 'package:uhave_project/modules/category.dart';
import 'package:uhave_project/repository/repository.dart';

class CategoryService{
  late Repository _respository;

  CategoryService(){
    _respository = Repository();
  }
  // creating data
  saveCategory(Category category) async{
    return await _respository.insertData('categories', category.categoryMap());
  }

  readCategories() async{
    return await _respository.readData('categories');
  }

  // read data from table by id
  readCategoriesById(categoryId) async {
    return await _respository.readDataById('categories',categoryId);
  }

  // update data from table
  updateCategory(Category category) async {
    return await _respository.updateData('categories', category.categoryMap());
  }

  // delete category from database
  deleteCategory(categoryId) async{
    return await _respository.deleteData('categories',categoryId);
  }
}