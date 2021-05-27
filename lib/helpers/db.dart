import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/TodoModel.dart';

class DatabaseHelper {
  static DatabaseHelper _instance;
  static Database _database;
  static const String DB_NAME = "db.db";
  static const int DB_VERSION = 1;

  // Todo Table
  String todoTable = 'todo_table';
  String colId = 'id';
  String colTodo = 'todo';
  String colIsCompleted = 'isCompleted';

  DatabaseHelper._getInstance();

  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._getInstance();
    }

    return _instance;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }

    return _database;
  }

  Future<Database> initDB() async {
    return await openDatabase(
      path.join(await getDatabasesPath(), DB_NAME),
      version: DB_VERSION,
      onCreate: onCreate,
    );
  }

  void onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $todoTable' +
          '($colId INTEGER PRIMARY KEY,' +
          '$colTodo TEXT,' +
          '$colIsCompleted INTEGER)',
    );
  }

  Future<List<TodoModel>> getTodos() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(todoTable);
    return List.generate(maps.length, (i) => TodoModel.fromMapObject(maps[i]));
  }

  Future<int> insertTodo(TodoModel todo) async {
    Database db = await database;

    return await db.insert(
      todoTable,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateTodo(TodoModel todo) async {
    Database db = await database;
    return await db.update(
      todoTable,
      todo.toMap(),
      where: '$colId = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(TodoModel todo) async {
    Database db = await database;

    return await db.delete(
      todoTable,
      where: '$colId = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> getTodoCount() async {
    Database db = await database;
    List<Map<String, dynamic>> query = await db.rawQuery(
      'SELECT COUNT (*) from $todoTable',
    );

    return Sqflite.firstIntValue(query);
  }
}
