import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection{
  setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path,'uhave');
    var database =
        await openDatabase(path, version: 1,onCreate: _onCreatingDatabase);
    return database;
  }
  // method to create a new database and it is called when ever the app is launched once
  _onCreatingDatabase(Database database, int version) async{
    await database.execute("CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT)");
    await database.execute("CREATE TABLE detailedList(id INTEGER PRIMARY KEY, categoryId INTEGER,konu TEXT,aciklama TEXT,tarih TEXT)");
  }
}