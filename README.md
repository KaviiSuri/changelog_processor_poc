<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->


This is a Proof Of Concept for GSOC project "Changelog Parser for pub.dev".

This takes in package name and Changelog.md url and generates a modified change log with versions as hyperlinks.

## Features

- Get a modified log file with all versions as links
- Fetch versions from pub.dev/api to prevent broken link errors
- Generate Hyperlinks for all occurances, not just headings.


## Usage

### Generate Modified Changelog from URL.

```dart
  ChangelogProcessor cp = await ChangelogProcessor.fromChangeLogURL(
      "uuid",
      Uri.parse(
          "https://raw.githubusercontent.com/Daegalus/dart-uuid/master/CHANGELOG.md"));
  String modifiedLogs = cp.getProccessedLog();
```

### Generate Modified Changelog from MD Source

```dart
  String source = """
  v1.0.0
  ....
  ....
  """;

  List<String> versions = [
    "1.0.0",
    "1.0.1",
    ...
  ]

  String modifiedLogs = ChangelogProcessor.fromChangeLogSource("..name", versions, source).getProcessedLog();
```

## Limitations

This project solves a simplified version of the problem using regex `r"v?(\d+.\d+.\d+)`, which might not be enough and edge cases might arise.

I hope to improve and enhance it in my GSOC internship.
