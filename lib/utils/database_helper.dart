import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/book.dart';
import '../models/models/user.dart';
// import '../models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    if (kIsWeb || !(Platform.isIOS || Platform.isAndroid)) {
      throw UnsupportedError("sqflite is not supported on this platform.");
    }

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'books.db');

    // Print the database location
    print('Database location: $path');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE books (
            id TEXT PRIMARY KEY,
            title TEXT,
            author TEXT,
            description TEXT,
            rating REAL,
            isRead INTEGER,
            imageUrl TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE users (
            id TEXT PRIMARY KEY,
            username TEXT,
            email TEXT,
            password TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertBook(Book book) async {
    final db = await database;
    int result = await db.insert('books', book.toMap());

    // Print the inserted data
    print('Inserted book: ${book.toMap()}');

    return result;
  }

  Future<int> updateBook(Book book) async {
    final db = await database;
    int result = await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );

    // Print the updated data
    print('Updated book: ${book.toMap()}');

    return result;
  }

  Future<int> deleteBook(String id) async {
    final db = await database;
    int result = await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );

    // Print the deleted book id
    print('Deleted book with id: $id');

    return result;
  }

  Future<List<Book>> getBooks() async {
    final db = await database;
    final maps = await db.query('books');

    if (maps.isEmpty) return [];

    return maps.map((map) => Book.fromMap(map)).toList();
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUser(String email, String password) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }
}
