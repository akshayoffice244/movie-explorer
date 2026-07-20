import 'package:hive/hive.dart';

class RecentSearchRepository {
  static const String boxName = 'recent_searches';

  Box<String> get _box =>
      Hive.box<String>(boxName);

  Future<void> saveSearch(String query) async {
    final search = query.trim();

    if (search.isEmpty) return;

    final searches = _box.values.toList();

    if (searches.contains(search)) {
      final key = _box.keys.firstWhere(
            (key) => _box.get(key) == search,
      );

      await _box.delete(key);
    }

    await _box.add(search);

    if (_box.length > 10) {
      await _box.deleteAt(0);
    }
  }

  List<String> getRecentSearches() {
    return _box.values.toList().reversed.toList();
  }

  Future<void> removeSearch(String query) async {
    final key = _box.keys.firstWhere(
          (key) => _box.get(key) == query,
      orElse: () => null,
    );

    if (key != null) {
      await _box.delete(key);
    }
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}