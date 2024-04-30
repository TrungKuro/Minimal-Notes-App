import 'package:flutter/material.dart';
import 'package:minimal_notes_app/models/note_database.dart';
import 'package:minimal_notes_app/pages/notes_page.dart';
import 'package:provider/provider.dart';

void main() async {
  // Khởi tạo Note sử dụng Isar Database
  WidgetsFlutterBinding.ensureInitialized;
  await NoteDatabase.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDatabase(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}
