import 'dart:io';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../ModelClass/ModelClass.dart'; // Import your model class

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _database;

  // Future<List<BudgetRecord>> fetchData() async {
  //   final db = await _database;
  //   try {
  //     final List<Map<String, dynamic>> maps = await db!.query("budget_table");
  //     return List.generate(maps.length, (i) {
  //       return BudgetRecord.fromMap(maps[i]);
  //     });
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //     return [];
  //   }
  // }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'smart_budget.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE budget_table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          category TEXT NOT NULL,
          amount REAL NOT NULL,
          date TEXT NOT NULL,
          time TEXT NOT NULL,
          type TEXT NOT NULL,
          memo TEXT,
          description TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE balance_table (
          id INTEGER PRIMARY KEY,
          balance REAL NOT NULL
        )
      ''');
      await db.insert('balance_table', {'id': 1, 'balance': 0.0});
      //Fluttertoast.showToast(msg: "Database and tables created successfully");
    } catch (e) {
      print('Error creating tables: $e');
    }
  }

  Future<void> _updateBalance(double amount, String type) async {
    Database db = await database;
    try {
      double currentBalance = await _getCurrentBalance();
      double newBalance = type == 'Income' ? currentBalance + amount : currentBalance - amount;

      await db.update(
        'balance_table',
        {'balance': newBalance},
        where: 'id = ?',
        whereArgs: [1],
      );
    } catch (e) {
      print('Error updating balance: $e');
    }
  }

  Future<double> _getCurrentBalance() async {
    Database db = await database;
    try {
      final List<Map<String, dynamic>> result = await db.query(
        'balance_table',
        where: 'id = ?',
        whereArgs: [1],
      );
      return result.isNotEmpty ? result.first['balance'] as double : 0.0;
    } catch (e) {
      print('Error getting current balance: $e');
      return 0.0;
    }
  }

  Future<double> getBalance() async {
    return await _getCurrentBalance();
  }

  Future<int> insertData(BudgetRecord record) async {
    Database db = await database;
    try {
      await _updateBalance(record.amount, record.type);
      return await db.insert('budget_table', record.toMap());
    } catch (e) {
      print('Error inserting data: $e');
      return -1;
    }
  }

  Future<int> updateRecord(BudgetRecord record) async {
    Database db = await database;
    try {
      return await db.update(
        'budget_table',
        record.toMap(),
        where: 'id = ?',
        whereArgs: [record.id],
      );
    } catch (e) {
      print('Error updating data: $e');
      return -1;
    }
  }

  Future<int> deleteRecord(int? id) async {
    Database db = await database;
    try {
      final List<Map<String, dynamic>> result = await db.query(
        'budget_table',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (result.isNotEmpty) {
        String type = result.first['type'] as String;
        double amount = result.first['amount'] as double;
        await _updateBalance(amount, type == 'Income' ? 'Expense' : 'Income');
      }
      return await db.delete(
        'budget_table',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting data: $e');
      return -1;
    }
  }

  Future close() async {
    Database db = await database;
    db.close();
  }

  Future<List<BudgetRecord>> fetchData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('budget_table');

    return List.generate(maps.length, (i) {
      return BudgetRecord(
        id: maps[i]['id'],
        category: maps[i]['category'],
        amount: maps[i]['amount'],
        date: maps[i]['date'],
        time: maps[i]['time'],
        type: maps[i]['type'],
        memo: maps[i]['memo'],
        description: maps[i]['description'],
      );
    });
  }

}
