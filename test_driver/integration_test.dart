import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

// Flutter web integration testing is in the weeds: https://github.com/flutter/flutter/issues/86985

/*

Fixes https://github.com/flutter/flutter/issues/86985

Taking a screenshot during integration testing for web works when not in null-safe mode but dies with a null-to-string cast when in null-safe mode. This PR adds a null check to bail early in a loop when no screenshots need to be processed.

*/
Future<void> main() => integrationDriver(
      onScreenshot: (String screenshotName, List<int> screenshotBytes) async {
        final File image = await File('/tmp/screenshots/$screenshotName.png').create(recursive: true);
        image.writeAsBytesSync(screenshotBytes);
        return true;
      },
    );
