import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/book_service.dart';
// import '../utils/preferences.dart';
import '../widgets/book_list_item.dart';

class HomeScreen extends StatefulWidget {
  final String sortOrder;

  HomeScreen({required this.sortOrder});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookService = Provider.of<BookService>(context);

    // Fetch books when HomeScreen is built
    bookService.fetchBooks();

    final books = bookService.books;

    books.sort((a, b) {
      switch (widget.sortOrder) {
        case 'title':
          return a.title.compareTo(b.title);
        case 'author':
          return a.author.compareTo(b.author);
        case 'rating':
          return b.rating.compareTo(a.rating);
        default:
          return a.title.compareTo(b.title);
      }
    });

    final filteredBooks = books.where((book) {
      final query = _searchQuery.toLowerCase();
      return book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Library'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredBooks.length,
        itemBuilder: (ctx, i) => BookListItem(book: filteredBooks[i]),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-edit-book');
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            child: Icon(Icons.view_list),
            onPressed: () {
              Navigator.pushNamed(context, '/view-books');
            },
          ),
        ],
      ),
    );
  }
}
