import 'dart:convert';

class CacheModel {
  final DateTime addedTime;
  final int expiry;
  final String data;
  CacheModel({
    required this.addedTime,
    required this.expiry,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addedTime': addedTime.millisecondsSinceEpoch,
      'expiry': expiry,
      'data': data,
    };
  }

  factory CacheModel.fromMap(Map<String, dynamic> map) {
    return CacheModel(
      addedTime: DateTime.fromMillisecondsSinceEpoch(map['addedTime'] as int),
      expiry: map['expiry'] as int,
      data: map['data'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CacheModel.fromJson(String source) =>
      CacheModel.fromMap(json.decode(source) as Map<String, dynamic>);
}