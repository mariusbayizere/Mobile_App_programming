import 'package:flutter/material.dart';
import '../models/book.dart';
import '../utils/database_helper.dart';

class BookService with ChangeNotifier {
  List<Book> _books = [];

  List<Book> get books => _books;

  Future<void> fetchBooks() async {
    _books = await DatabaseHelper().getBooks();
    notifyListeners();
  }

  void sortBooks(String sortOrder) {
    switch (sortOrder) {
      case 'title':
        _books.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'author':
        _books.sort((a, b) => a.author.compareTo(b.author));
        break;
      case 'rating':
        _books.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    notifyListeners();
  }

  Future<void> addBook(Book book) async {
    await DatabaseHelper().insertBook(book);
    _books.add(book);
    notifyListeners();
  }

  Future<void> updateBook(Book book) async {
    await DatabaseHelper().updateBook(book);
    final index = _books.indexWhere((b) => b.id == book.id);
    if (index != -1) {
      _books[index] = book;
      notifyListeners();
    }
  }

  Future<void> deleteBook(String id) async {
    await DatabaseHelper().deleteBook(id);
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }

  List<Book> searchBooks(String query) {
    return _books.where((book) {
      final titleLower = book.title.toLowerCase();
      final authorLower = book.author.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }
}
