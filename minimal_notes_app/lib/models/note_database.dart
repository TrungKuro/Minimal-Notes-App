import 'package:isar/isar.dart';
import 'package:minimal_notes_app/models/note.dart';
import 'package:path_provider/path_provider.dart';

/// Các tính năng cho Note trên Database
class NoteDatabase {
  /* ----------------------------------------------------------------------- */

  static late Isar isar;

  /// Khởi tạo Database
  static Future<void> initialize() async {
    // Chờ lấy đường dẫn nơi ứng dụng sẽ lưu trữ dữ liệu của người dùng
    final dir = await getApplicationDocumentsDirectory();

    // Cung cấp thông tin đường dẫn đó cho Iar Database
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  /* ----------------------------------------------------------------------- */

  /// Danh sách các Note hiện có để hiển thị lên ứng dụng
  final List<Note> currentNotes = [];

  /**
   * FETCH
   * Về cơ bản, "tìm nạp" là quá trình lấy dữ liệu từ Database và cung cấp dữ liệu đó cho ứng dụng.
   */

  ///! Read - Xem tất cả toàn bộ note có trong Database
  Future<void> fetchNotes() async {
    // Lấy toàn bộ Note có trong Database
    List<Note> fetchedNotes = await isar.notes.where().findAll();

    // Cập nhập danh sách mới các Note
    // Để tránh trùng lặp các Note, ta cần xoá hết danh sách cũ và nạp danh sách mới
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
  }

  /* ----------------------------------------------------------------------- */

  ///! Create - Tạo một note và lưu vào Database
  Future<void> addNote(String textFromUser) async {
    // Tạo một Note mới để chứa nội dung từ người dùng nhập vào
    final newNote = Note()..text = textFromUser;

    // Và lưu Note đó vào Database
    await isar.writeTxn(() => isar.notes.put(newNote));

    // Sau khi tạo Note mới đó xong
    // Ta cần cập nhập lại danh sách mới các Note cho ứng dụng
    await fetchNotes();
  }

  ///! Update - Cập nhập cho một note trong Database
  Future<void> updateNote(int id, String newText) async {
    // Để cập nhập Note, ta cần cung cấp ID của Note đó trong Database
    final existingNote = await isar.notes.get(id);

    // Tuy nhiên ta cần kiểm tra tại ID đó, Note đã có tồn tại chưa, tức ko rỗng!
    if (existingNote != null) {
      // Nếu Note đó có tồn tại, ta cần cung cấp nội dung mới cho Note đó
      existingNote.text = newText;

      // Nạp nội dung mới cho Note đó
      await isar.writeTxn(() => isar.notes.put(existingNote));

      // Sau khi cập nhập cho Note đó xong
      // Ta cần cập nhập lại danh sách mới các Note cho ứng dụng
      await fetchNotes();
    }
  }

  ///! Delete - Xoá một note khỏi Database
  Future<void> deleteNote(int id) async {
    // Để xoá Note, ta cần cung cấp ID của Note đó trong Database
    await isar.writeTxn(() => isar.notes.delete(id));

    // Sau khi xoá xong, ta cần cập nhập lại danh sách mới các Note cho ứng dụng
    await fetchNotes();
  }
}
