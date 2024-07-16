import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/preferences.dart';
import '../providers/theme_provider.dart';
import 'home_screen.dart'; // Import your HomeScreen here

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _sortOrder;
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _sortOrder = Preferences.getSortOrder() ?? 'title';
    _isDarkMode = Preferences.getThemeMode() == 'dark';
  }

  void _setSortOrder(String? order) {
    if (order == null) return;
    setState(() {
      _sortOrder = order;
    });
    Preferences.setSortOrder(order);
    // Navigate to HomeScreen with the new sort order
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HomeScreen(sortOrder: _sortOrder), // Pass sortOrder to HomeScreen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sort by:', style: TextStyle(fontSize: 20)),
            RadioListTile<String>(
              title: Text('Title'),
              value: 'title',
              groupValue: _sortOrder,
              onChanged: _setSortOrder,
            ),
            RadioListTile<String>(
              title: Text('Author'),
              value: 'author',
              groupValue: _sortOrder,
              onChanged: _setSortOrder,
            ),
            RadioListTile<String>(
              title: Text('Rating'),
              value: 'rating',
              groupValue: _sortOrder,
              onChanged: _setSortOrder,
            ),
            SizedBox(height: 20),
            Text('Theme:', style: TextStyle(fontSize: 20)),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                });
                themeProvider.toggleTheme(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}





// new setting screen

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../utils/preferences.dart';
// import '../providers/theme_provider.dart';

// class SettingsScreen extends StatefulWidget {
//   @override
//   _SettingsScreenState createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   late String _sortOrder;
//   late bool _isDarkMode;

//   @override
//   void initState() {
//     super.initState();
//     _sortOrder = Preferences.getSortOrder() ?? 'title';
//     _isDarkMode = Preferences.getThemeMode() == 'dark';
//   }

//   void _setSortOrder(String? order) {
//     if (order == null) return;
//     setState(() {
//       _sortOrder = order;
//     });
//     Preferences.setSortOrder(order);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Sort by:', style: TextStyle(fontSize: 20)),
//             RadioListTile<String>(
//               title: Text('Title'),
//               value: 'title',
//               groupValue: _sortOrder,
//               onChanged: _setSortOrder,
//             ),
//             RadioListTile<String>(
//               title: Text('Author'),
//               value: 'author',
//               groupValue: _sortOrder,
//               onChanged: _setSortOrder,
//             ),
//             RadioListTile<String>(
//               title: Text('Rating'),
//               value: 'rating',
//               groupValue: _sortOrder,
//               onChanged: _setSortOrder,
//             ),
//             SizedBox(height: 20),
//             Text('Theme:', style: TextStyle(fontSize: 20)),
//             SwitchListTile(
//               title: Text('Dark Mode'),
//               value: _isDarkMode,
//               onChanged: (bool value) {
//                 setState(() {
//                   _isDarkMode = value;
//                 });
//                 themeProvider.toggleTheme(value);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
