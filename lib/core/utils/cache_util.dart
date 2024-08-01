import 'dart:convert';

import 'package:expense_tracker/core/common/models/cache_model.dart';
import 'package:expense_tracker/core/utils/local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';



class CacheUtil {
  
  // For caching http responses

  static Map<String, dynamic> _storedCache = {};

  static Future<String?> get({
    required String key,
    required Future<Response> Function() func,
    required int expiry,
  }) {

    // Returns the response if exists in cache and if not expired

    _fetchCache();
    DateTime now = DateTime.now();
    if (_storedCache.containsKey(key)) {
      final res = CacheModel.fromJson(_storedCache[key]!);
      int difference = now.difference(res.addedTime).inMinutes;
      if (difference > res.expiry) {
        debugPrint('$key fetching from server...');
        return func().then((res) {
          _storedCache.addAll({
            key: CacheModel(
              addedTime: now,
              expiry: expiry,
              data: res.body,
            ).toJson(),
          });
          _commitCache();
          return res.body;
        });
      }
      debugPrint('$key fetching from cache...');

      return Future(() => res.data);
    } else {
      debugPrint('$key fetching from server...');

      return func().then((res) {
        _storedCache.addAll({
          key: CacheModel(
            addedTime: now,
            expiry: expiry,
            data: res.body,
          ).toJson(),
        });
        _commitCache();
        return res.body;
      });
    }
  }

  static void clearData(String key) {

    // For clearing the cache using the key parameter

    _storedCache.remove(key);
    _commitCache();
  }

  static void _commitCache() async {

    // Stores the response to local storage as a new key-value pair

    if (LocalStorage.containsKey('system_cache')) {
      LocalStorage.delete('system_cache');
    }
    LocalStorage.writeString('system_cache', jsonEncode(_storedCache));
  }

  static void _fetchCache() {
    // Reads all data from local storage
    final cache = LocalStorage.readString('system_cache');
    if (cache != null) {
      _storedCache = jsonDecode(cache);
    }
  }
}
