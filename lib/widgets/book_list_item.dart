import 'dart:io';

import 'package:flutter/material.dart';
import '../models/book.dart';

class BookListItem extends StatelessWidget {
  final Book book;

  BookListItem({required this.book});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: book.imageUrl != null
          ? Image.file(
              File(book.imageUrl!),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
          : Icon(Icons.book),
      title: Text(book.title),
      subtitle: Text(book.author),
      trailing: Icon(book.isRead ? Icons.check : Icons.book),
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: book);
      },
    );
  }
}
