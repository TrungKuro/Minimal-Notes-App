import 'package:isar/isar.dart';

/// This line needed to generate (g) file.
/// Then run: "dart run build_runner build".
part 'note.g.dart';

/**
 * Isar Database - Super Fast Cross-Platform Database for Flutter
 */

/// Tạo một đối tượng tuỳ chỉnh, có tên là Note.
/// Mỗi Note sẽ có ID riêng do Isar Database quản lý.
/// Cho phép ta lưu một số thứ vào Isar Database.
/// Cụ thể bên trong mỗi Note sẽ có một String.
@Collection()
class Note {
  /// Tự động tăng số ID cho từng Note mới được tạo.
  Id id = Isar.autoIncrement;

  /// Lưu trữ nội dung của Note.
  /// Bởi vì nội dung sẽ được thêm vào sau, ko có Note rỗng.
  /// Nên ta cần thuộc tính "late".
  late String text;
}