import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_notes_app/components/my_drawer.dart';
import 'package:minimal_notes_app/models/note.dart';
import 'package:minimal_notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // Bộ "Text Controller" để truy cập người dùng đã nhập những gì
  final textController = TextEditingController();

  /* ----------------------------------------------------------------------- */

  @override
  void initState() {
    super.initState();
    // Cập nhập tất cả Note mỗi khi khởi động ứng dụng
    readNotes();
  }

  ///! Read all note
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  /* ----------------------------------------------------------------------- */

  ///! Create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Note'),
        content: TextField(
          controller: textController,
        ),
        // Nút xác thực tạo Note mới với nội dung trong TextField
        actions: [
          MaterialButton(
            onPressed: () {
              // Thêm Note mới vào Database
              context.read<NoteDatabase>().addNote(textController.text);
              // Xoá nội dung hiện có trong TextField trước khi thoát ra
              textController.clear();
              // Pop Dialog Box
              Navigator.pop(context);
            },
            child: const Text('Create'),
          )
        ],
      ),
    );
  }

  ///! Update a note
  void updateNote(Note note) {
    // Điền lại nội dung trong Note vào TextField
    textController.text = note.text;

    // Hiện lên Dialog để người dùng nhập lại nội dung trong TextFile
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Note'),
        content: TextField(
          controller: textController,
        ),
        // Nút xác thực tạo Note mới với nội dung trong TextField
        actions: [
          MaterialButton(
            onPressed: () {
              // Cập nhập lại Note này vào Database
              context.read<NoteDatabase>().updateNote(note.id, textController.text);
              // Xoá nội dung hiện có trong TextField trước khi thoát ra
              textController.clear();
              // Pop Dialog Box
              Navigator.pop(context);
            },
            child: const Text('Update'),
          )
        ],
      ),
    );
  }

  ///! Delete a note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // Note Database
    final noteDatabase = context.watch<NoteDatabase>();

    // Current Notes
    List<Note> currentNodes = noteDatabase.currentNotes;

    return Scaffold(
      /* ----------------------------- Top App ----------------------------- */
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      /* ---------------------------- Bottom App --------------------------- */
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.amber,
        onPressed: createNote,
        tooltip: 'Create New Note',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      /* ---------------------------- Center App --------------------------- */
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADING
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          // LIST OF NOTES
          Expanded(
            child: ListView.builder(
              itemCount: currentNodes.length,
              itemBuilder: (context, index) {
                // Get individual note
                final note = currentNodes[index];
                // List tile UI
                return ListTile(
                  title: Text(note.text),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit Button
                      IconButton(
                        onPressed: () => updateNote(note),
                        icon: const Icon(Icons.edit),
                      ),
                      // Delete Button
                      IconButton(
                        onPressed: () => deleteNote(note.id),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
