import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static const String _historyKeyPrefix = 'quiz_history_';

  Future<void> saveQuizResult(String quizId, int score, int total) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_historyKeyPrefix$quizId';
    final value = '$score/$total';
    await prefs.setString(key, value);
  }

  Future<String?> getQuizResult(String quizId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_historyKeyPrefix$quizId';
    return prefs.getString(key);
  }

  Future<Map<String, String>> getAllQuizResults() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final Map<String, String> history = {};

    for (String key in keys) {
      if (key.startsWith(_historyKeyPrefix)) {
        final quizId = key.substring(_historyKeyPrefix.length);
        final value = prefs.getString(key);
        if (value != null) {
          history[quizId] = value;
        }
      }
    }
    return history;
  }
}
