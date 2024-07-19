// import 'dart:io';

// import 'package:flutter/material.dart';
// import '../models/book.dart';

// class BookListItem extends StatelessWidget {
//   final Book book;

//   BookListItem({required this.book});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: book.imageUrl != null
//           ? Image.file(
//               File(book.imageUrl!),
//               width: 50,
//               height: 50,
//               fit: BoxFit.cover,
//             )
//           : Icon(Icons.book),
//       title: Text(book.title),
//       subtitle: Text(book.author),
//       trailing: Icon(book.isRead ? Icons.check : Icons.book),
//       onTap: () {
//         Navigator.pushNamed(context, '/detail', arguments: book);
//       },
//     );
//   }
// }

// import 'dart:io';

// import 'package:flutter/material.dart';
// import '../models/book.dart';

// class BookListItem extends StatelessWidget {
//   final Book book;
//   final bool isHorizontal;

//   BookListItem({required this.book, required this.isHorizontal});

//   @override
//   Widget build(BuildContext context) {
//     return isHorizontal
//         ? Container(
//             width: 150,
//             margin: EdgeInsets.symmetric(horizontal: 8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 120,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       image: book.imageUrl != null
//                           ? FileImage(File(book.imageUrl!))
//                           : AssetImage('assets/placeholder.png')
//                               as ImageProvider,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 8.0),
//                 Text(
//                   book.title,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 Text(
//                   book.author,
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//               ],
//             ),
//           )
//         : ListTile(
//             leading: book.imageUrl != null
//                 ? Image.file(
//                     File(book.imageUrl!),
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   )
//                 : Icon(Icons.book),
//             title: Text(book.title),
//             subtitle: Text(book.author),
//             trailing: Icon(book.isRead ? Icons.check : Icons.book),
//             onTap: () {
//               Navigator.pushNamed(context, '/detail', arguments: book);
//             },
//           );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../screens/book_details.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final bool isHorizontal;

  BookListItem({required this.book, required this.isHorizontal});

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return Container(
        width: 150,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailScreen(book: book),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(10.0), // Set border radius here
                child: book.imageUrl != null
                    ? Image.file(
                        File(book.imageUrl!),
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 150,
                        height: 150,
                        color: Colors.grey,
                        child: Icon(Icons.book, size: 50),
                      ),
              ),
              SizedBox(height: 8.0),
              Text(
                book.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5.0), // Set border radius here
            child: book.imageUrl != null
                ? Image.file(
                    File(book.imageUrl!),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.book),
          ),
          title: Text(book.title),
          subtitle: Text(book.author),
          trailing: Icon(book.isRead ? Icons.check : Icons.book),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailScreen(book: book),
              ),
            );
          },
        ),
      );
    }
  }
}



// import 'dart:io';
// import 'package:flutter/material.dart';
// import '../models/book.dart';
// import '../screens/book_details.dart';

// class BookListItem extends StatelessWidget {
//   final Book book;
//   final bool isHorizontal;

//   BookListItem({required this.book, required this.isHorizontal});

//   @override
//   Widget build(BuildContext context) {
//     if (isHorizontal) {
//       return Container(
//         width: 150,
//         margin: EdgeInsets.symmetric(horizontal: 8.0),
//         child: GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => BookDetailScreen(book: book),
//               ),
//             );
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               book.imageUrl != null
//                   ? Image.file(
//                       File(book.imageUrl!),
//                       width: 150,
//                       height: 150,
//                       fit: BoxFit.cover,
//                     )
//                   : Container(
//                       width: 150,
//                       height: 150,
//                       color: Colors.grey,
//                       child: Icon(Icons.book, size: 50),
//                     ),
//               SizedBox(height: 8.0),
//               Text(
//                 book.title,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//         ),
//       );
//     } else {
//       return Container(
//         child: ListTile(
//           leading: book.imageUrl != null
//               ? Image.file(
//                   File(book.imageUrl!),
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.cover,
//                 )
//               : Icon(Icons.book),
//           title: Text(book.title),
//           subtitle: Text(book.author),
//           trailing: Icon(book.isRead ? Icons.check : Icons.book),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => BookDetailScreen(book: book),
//               ),
//             );
//           },
//         ),
//       );
//     }
//   }
// }
