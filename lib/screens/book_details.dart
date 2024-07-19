import 'dart:io';
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  late Book _currentBook;
  double _rating = 0;

  @override
  void initState() {
    super.initState();
    _currentBook = widget.book;
    _rating = widget.book.rating;
  }

  void _toggleReadStatus() async {
    final updatedBook = _currentBook.copyWith(isRead: !_currentBook.isRead);
    await Provider.of<BookService>(context, listen: false)
        .updateBook(updatedBook);
    setState(() {
      _currentBook = updatedBook;
    });
  }

  Future<void> _updateBookAndShowConfirmation() async {
    final updatedBook =
        _currentBook.copyWith(rating: _rating, isRead: _currentBook.isRead);
    await Provider.of<BookService>(context, listen: false)
        .updateBook(updatedBook);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Book updated successfully!')),
    );

    // Navigate back to the home screen after the confirmation message is shown
    await Future.delayed(
        Duration(seconds: 1)); // Delay to ensure snackbar is visible
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Book'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            _currentBook.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.file(
                      File(_currentBook.imageUrl!),
                      width: 150,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(Icons.book, size: 150),
            SizedBox(height: 20),
            Text(
              _currentBook.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              _currentBook.author,
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              _currentBook.isRead ? 'In Stock' : 'Not Available',
              style: TextStyle(
                  fontSize: 16,
                  color: _currentBook.isRead ? Colors.green : Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              _currentBook.description ?? 'No description available',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Rate this book:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Slider(
              value: _rating.clamp(0.0, 5.0),
              onChanged: (newRating) {
                setState(() {
                  _rating = newRating.clamp(0.0, 5.0);
                });
              },
              divisions: 10,
              min: 0,
              max: 5,
              label: _rating.toString(),
            ),
            Text(
              'Rating: $_rating',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleReadStatus,
              child:
                  Text(_currentBook.isRead ? 'Mark as Unread' : 'Mark as Read'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    _currentBook.isRead ? Colors.red : Colors.green,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateBookAndShowConfirmation,
              child: Text('Get the Book'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
