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
            trailing: IconButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // Set the text color here
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
              ),
              icon: Icon(Icons.delete),
              onPressed: () async {
                final confirm = await showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Confirm Deletion'),
                    content: Text('Are you sure you want to delete this book?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                );

                if (confirm) {
                  bookService.deleteBook(book.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Book deleted successfully')),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
