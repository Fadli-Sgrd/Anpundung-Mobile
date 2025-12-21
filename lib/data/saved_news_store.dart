import 'package:flutter/foundation.dart';

class SavedNewsStore {
  // ValueNotifier so UI can listen and update when saved list changes
  static final ValueNotifier<List<Map<String, String>>> saved = ValueNotifier([]);

  static void add(Map<String, String> item) {
    // Prevent duplicates by title
    final exists = saved.value.any((e) => e['title'] == item['title']);
    if (!exists) {
      saved.value = [...saved.value, item];
    }
  }

  static void removeAt(int index) {
    final list = [...saved.value];
    if (index >= 0 && index < list.length) {
      list.removeAt(index);
      saved.value = list;
    }
  }

  static void removeByTitle(String title) {
    saved.value = saved.value.where((e) => e['title'] != title).toList();
  }

  static List<Map<String, String>> getAll() => saved.value;
}
