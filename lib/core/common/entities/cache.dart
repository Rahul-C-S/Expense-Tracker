class Cache {
  final DateTime addedTime;
  final int expiry;
  final String data;

  Cache({
    required this.addedTime,
    required this.expiry,
    required this.data,
  });
}
