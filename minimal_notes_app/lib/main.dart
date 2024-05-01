import 'package:flutter/material.dart';
import 'package:minimal_notes_app/models/note_database.dart';
import 'package:minimal_notes_app/pages/notes_page.dart';
import 'package:minimal_notes_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // Khởi tạo Note sử dụng Isar Database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        // Theo dõi sự thay đổi trong Database
        ChangeNotifierProvider(create: (context) => NoteDatabase()),
        // Theo dõi sự thay đổi trong Theme
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
