import 'package:uhave_project/modules/detailedList.dart';
import 'package:uhave_project/repository/detailedlist_repository.dart';

class DetailedListService{
  late DetailedListRepository _respository;

  DetailedListService(){
    _respository = DetailedListRepository();
  }
  // creating data
  saveDetailedList(detailedList list) async{
    return await _respository.insertData('detailedList', list.detailedListMap());
  }

  readAllDetailedList(categoryId) async{
    return await _respository.readAllData('detailedList',categoryId);
  }
  readDetailedList(categoryId,tarih) async{
    return await _respository.readData('detailedList',categoryId,tarih);
  }

  // read data from table by id
  readDetailedListById(itemId) async {
    return await _respository.readDataById('detailedList',itemId);
  }

  // update data from table
  updateDetailedList(detailedList list) async {
    return await _respository.updateData('detailedList', list.detailedListMap());
  }

  // delete category from database
  deleteDetailedList(itemId) async{
    return await _respository.deleteData('detailedList',itemId);
  }
}