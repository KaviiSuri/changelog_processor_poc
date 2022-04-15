library changelog_proccessor_poc;

import 'package:changelog_proccessor_poc/utils/package_info.dart';
import "package:http/http.dart" as http;

/// A class to process CHANGELOG.md files by passing in source or url
class ChangelogProcessor {
  static const String kVersionRegex = r"v?(\d+.\d+.\d+)";
  static const String kPubDevRoot = "https://pub.dev/packages";

  String source;
  List<String> versions;
  String packageName;

  static Future<ChangelogProcessor> fromChangeLogURL(
      String packageName, Uri changlogURL) async {
    String source = await http.read(changlogURL);

    PackageInfo pkgInfo = await PackageInfo.fromName(packageName);

    return ChangelogProcessor.fromChangeLogSource(
        packageName, pkgInfo.versions, source);
  }

  ChangelogProcessor.fromChangeLogSource(
    this.packageName,
    this.versions,
    this.source,
  );

  String getProccessedLog() {
    return source.replaceAllMapped(RegExp(kVersionRegex), (match) {
      String label = match.input.substring(match.start, match.end);
      String? potentialVersion = match.group(1);

      if (potentialVersion != null && versions.contains(potentialVersion)) {
        return versionToLink(label, potentialVersion);
      }

      return label;
    });
  }

  String versionToLink(String label, String version) {
    return '[$label]($kPubDevRoot/$packageName/versions/$version)';
  }
}
