import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:typing/domain/record_data_repository.dart';
import 'package:typing/domain/record_data.dart';

class SqlDatabaseRepository implements RecordDataRepository {
  SqlDatabaseRepository._();
  static final SqlDatabaseRepository db = SqlDatabaseRepository._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // DBがなかったら作る
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "RecordDB.db");

    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    return await db.execute("CREATE TABLE $_tableName ("
        "id TEXT PRIMARY KEY,"
        "recordDate INTEGER ,"
        "score INTEGER ,"
        "missType INTEGER ,"
        "speed REAL"
        ")");
  }

  static final _tableName = "RecordData";

  Future<int> registerRecordData(RecordData record) async {
    final db = await database;
    var res = 0;
    var fetch =
        await db.query(_tableName, where: "id = ?", whereArgs: [record.id]);
    if (fetch.isNotEmpty) {
      final db = await database;
      res = await db.update(_tableName, record.toMap(),
          where: "id = ?", whereArgs: [record.id]);
    } else {
      res = await db.insert(_tableName, record.toMap());
    }
    return res;
  }

  Future<List<RecordData>> fetchRecordDataAll() async {
    final db = await database;
    var res = await db.query(_tableName);
    List<RecordData> list =
        res.isNotEmpty ? res.map((c) => RecordData.fromMap(c)).toList() : [];
    return list;
  }

  @override
  Future<List<RecordData>> fetchRecordDataRange(
      DateTime start, DateTime end) async {
    final db = await database;
    var res = await db.query(_tableName,
        where: "createTime>? AND createTime<?",
        whereArgs: [
          start.millisecondsSinceEpoch - 1,
          end.millisecondsSinceEpoch + 1
        ]);
    List<RecordData> list =
        res.isNotEmpty ? res.map((c) => RecordData.fromMap(c)).toList() : [];
    return list;
  }

  Future<void> deleteRecordDataAll() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "RecordDB.db");
    await deleteDatabase(path);
    _database = null;
  }
}
