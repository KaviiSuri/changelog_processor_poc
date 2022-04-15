library changelog_proccessor_poc;

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

/// A class to process CHANGELOG.md files by passing in source or url
class ChangelogProcessor {
  static const String kVersionRegex = r"v?(\d.\d.\d)";
  static const String kPubDevRoot = "https://pub.dev/packages";

  String source;
  List<String> versions;
  String packageName;

  ChangelogProcessor.fromSource(
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
