import 'dart:convert';

import "package:http/http.dart" as http;

class PackageInfo {
  String name;
  List<String> versions;

  PackageInfo._(this.name, this.versions);
  static Future<PackageInfo> fromName(String name) async {
    http.Response res =
        await http.get(Uri.parse("https://pub.dev/api/documentation/uuid"));

    Map decodedResponse = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
    List<String> versions =
        (decodedResponse["versions"] as List).map((element) {
      return element["version"] as String;
    }).toList();
    return PackageInfo._(name, versions);
  }
}
