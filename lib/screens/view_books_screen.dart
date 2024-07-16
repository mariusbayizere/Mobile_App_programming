// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../services/book_service.dart';
// import 'add_edit_book_screen.dart';

// class ViewBooksScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final bookService = Provider.of<BookService>(context);
//     final books = bookService.books;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('View Books'),
//       ),
//       body: ListView.builder(
//         itemCount: books.length,
//         itemBuilder: (ctx, i) {
//           final book = books[i];
//           return ListTile(
//             title: Text(book.title),
//             subtitle: Text(book.author),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddEditBookScreen(book: book),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

//  new view book

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/book_service.dart';
import 'add_edit_book_screen.dart';

class ViewBooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookService = Provider.of<BookService>(context);
    final books = bookService.books;

    return Scaffold(
      appBar: AppBar(
        title: Text('View Books'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (ctx, i) {
          final book = books[i];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditBookScreen(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
