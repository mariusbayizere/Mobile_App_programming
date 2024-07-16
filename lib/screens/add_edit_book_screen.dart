import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class AddEditBookScreen extends StatefulWidget {
  static const routeName = '/add-edit-book';

  final Book? book;

  AddEditBookScreen({this.book});

  @override
  _AddEditBookScreenState createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _author;
  late String _description;
  late double _rating;
  late bool _isRead;
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _title = widget.book!.title;
      _author = widget.book!.author;
      _description = widget.book!.description;
      _rating = widget.book!.rating;
      _isRead = widget.book!.isRead;
      _imageUrl = widget.book!.imageUrl;
    } else {
      _title = '';
      _author = '';
      _description = '';
      _rating = 0.0;
      _isRead = false;
      _imageUrl = null;
    }
  }

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageUrl = pickedFile.path;
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.book != null) {
        Provider.of<BookService>(context, listen: false).updateBook(
          Book(
            id: widget.book!.id,
            title: _title,
            author: _author,
            description: _description,
            rating: _rating,
            isRead: _isRead,
            imageUrl: _imageUrl,
          ),
        );
      } else {
        Provider.of<BookService>(context, listen: false).addBook(
          Book(
            id: DateTime.now().toString(),
            title: _title,
            author: _author,
            description: _description,
            rating: _rating,
            isRead: _isRead,
            imageUrl: _imageUrl,
          ),
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book != null ? 'Edit Book' : 'Add Book'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _author,
                decoration: InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an author';
                  }
                  return null;
                },
                onSaved: (value) {
                  _author = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                initialValue: _rating.toString(),
                decoration: InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rating';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid rating';
                  }
                  return null;
                },
                onSaved: (value) {
                  _rating = double.parse(value!);
                },
              ),
              SwitchListTile(
                title: Text('Mark as Read'),
                value: _isRead,
                onChanged: (value) {
                  setState(() {
                    _isRead = value;
                  });
                },
              ),
              SizedBox(height: 10),
              _imageUrl == null
                  ? Text('No image selected.')
                  : Image.file(File(_imageUrl!)),
              TextButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
