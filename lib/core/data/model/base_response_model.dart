import '../enums/list_key_page_enum.dart';

class Page<T> {
  final List<T> list;
  final int count;

  factory Page.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) listDecode,
    ListKeysPage key,
  ) {
    return Page(
      list: json[key.name] != null
          ? (json[key.name] as List).map<T>((e) => listDecode.call(e)).toList()
          : [],
      count: json['total'] ?? 0,
    );
  }

  factory Page.fromListJson(
    Map<String, dynamic> json,
    T Function(dynamic json) listDecode,
    ListKeysPage key,
  ) {
    return Page(
      list: json[key.name] != null
          ? (json[key.name] as List).map<T>((e) => listDecode.call(e)).toList()
          : [],
      count: json['total'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'data: ${list.map((e) => '${e.toString()}\n')}';
  }

  Page({required this.list, required this.count});
}
