import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../services/book_service.dart';
import 'add_edit_book_screen.dart';

class BookDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Book book = ModalRoute.of(context)!.settings.arguments as Book;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditBookScreen(book: book),
                ),
              );
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<BookService>(context, listen: false)
                  .deleteBook(book.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            book.imageUrl != null
                ? Center(
                    child: Image.file(
                      File(book.imageUrl!),
                      height: 200,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(child: Text('No image available')),
            SizedBox(height: 20),
            Text('Author:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(book.author, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Description:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(book.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Rating:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(book.rating.toString(), style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Status:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(book.isRead ? 'Read' : 'Unread',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
