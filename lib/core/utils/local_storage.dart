import 'package:hive/hive.dart';

class LocalStorage {
  static final _box = Hive.box();

  static void writeString(String key, String value) {
    _box.put(key, value);
  }

  static String? readString(String key) {
    return _box.get(key);
  }

  static void delete(String key) {
    _box.delete(key);
  }

  static bool containsKey(String key){
    return _box.containsKey(key);
  }
}
