import 'package:flutter/material.dart';
import 'package:minimal_notes_app/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  // Chế độ "Light Mode" được sử dụng mặc định khi khởi động ứng dụng
  ThemeData _themeData = lightMode;

  /// Cho biết chế độ hiện tại
  ThemeData get themeData => _themeData;

  /// Cho biết chế độ hiện tại là "Dark Mode" hay ko?
  bool get isDarkMode => _themeData == darkMode;

  /// Cài đặt chế độ hiển thị
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  /// Đảo ngược chế độ hiển thị
  void toggle() {
    if (isDarkMode) {
      _themeData = lightMode;
    } else {
      _themeData = darkMode;
    }
  }
}
