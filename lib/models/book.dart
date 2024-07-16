// models/book.dart
class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final double rating;
  final bool isRead;
  final String? imageUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.rating,
    required this.isRead,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'rating': rating,
      'isRead': isRead ? 1 : 0,
      'imageUrl': imageUrl,
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      description: map['description'],
      rating: map['rating'],
      isRead: map['isRead'] == 1,
      imageUrl: map['imageUrl'],
    );
  }
}
