import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/book_detail_screen.dart';
import 'screens/add_edit_book_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/view_books_screen.dart';
import 'screens/auth_screen.dart';
import 'providers/theme_provider.dart';
import 'services/book_service.dart';
import 'services/auth_service.dart';
import 'utils/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BookService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: Consumer2<ThemeProvider, AuthService>(
        builder: (context, themeProvider, authService, child) {
          print('Theme Mode: ${themeProvider.themeMode}');
          return MaterialApp(
            title: 'Book Library',
            themeMode: themeProvider.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            initialRoute: authService.currentUser == null ? '/auth' : '/',
            routes: {
              '/': (context) =>
                  HomeScreen(sortOrder: Preferences.getSortOrder() ?? 'title'),
              '/book-detail': (context) => BookDetailScreen(),
              '/add-edit-book': (context) => AddEditBookScreen(),
              '/settings': (context) => SettingsScreen(),
              '/view-books': (context) => ViewBooksScreen(),
              '/auth': (context) => AuthScreen(),
            },
          );
        },
      ),
    );
  }
}
