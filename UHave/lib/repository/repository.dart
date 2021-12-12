import 'package:sqflite/sqflite.dart';
import 'package:uhave_project/repository/database_connection.dart';

class Repository{
  late DatabaseConnection _databaseConnection;

  Repository(){
   _databaseConnection = DatabaseConnection();
  }
   Database? _database;
  //to get the connection with the database
  Future<Database?> get database async{
    if(_database!=null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  //to insert values to the table in the given database
  insertData(table, data) async{
    var connection = await database;
    return await connection!.insert(table, data);
  }

  //read data from table
  readData(table) async{
    var connection = await database;
    return await connection!.query(table);
  }

  // read data from table by id
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection!.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  // update data from table
  updateData(table, data) async{
    var connection = await database;
    return await connection!.update(table, data, where: 'id=?',whereArgs: [data['id']]);
  }

  // delete data from table
  deleteData(table,itemId) async{
    var connection = await database;
    return await connection!.rawDelete("Delete from $table where id=$itemId");
  }
}