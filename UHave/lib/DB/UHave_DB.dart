import 'package:uhave_project/modules/category.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UHave_DB{
  static final UHave_DB instance = UHave_DB._init();
  static Database? _database;
  UHave_DB._init();

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('UHave.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version:1 , onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    await db.execute('''
    CREATE TABLE $tableCategory(
    ${categoryFields.category_id} $idType,
    ${categoryFields.category_name})
    ''');
  }

  Future<category> create(category new_category) async{
    final db = await instance.database;
    final category_id = await db.insert(tableCategory,new_category.toJson());
    return new_category.Copy(category_id: category_id);
  }

  Future<category> read(int id) async{
    final db = await instance.database;
    final maps = await db.query(
      tableCategory,
      columns: categoryFields.values,
      where: '${categoryFields.category_id}=?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return category.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id is not found');
    }
  }
  Future<List<category>> readAll() async{
    final db= await instance.database;
    final orderBy = '${categoryFields.category_id}';
    final result = await db.query(tableCategory, orderBy: orderBy);

    return result.map((json)=> category.fromJson(json)).toList();
  }

  Future<int> update(category to_edit) async{
    final db = await instance.database;

    return db.update(
        tableCategory,
        to_edit.toJson(),
        where: '${categoryFields.category_id} = ?',
        whereArgs: [to_edit.category_id]
    );
  }
  Future<int> delete(int id) async{
    final db = await instance.database;

    return await db.delete(
      tableCategory,
      where: '${categoryFields.category_id} = ?',
      whereArgs: [id],
    );
  }
  Future close() async{
    final db = await instance.database;

    db.close();
  }
}