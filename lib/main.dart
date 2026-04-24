import 'dart:async';

import 'package:acrova/core/app_runner/acrova_app.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'core/app_runner/app_initialization.dart';

final Logger log = Logger(
  printer: PrettyPrinter(dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart),
);

void main() {
  runZonedGuarded<Future<void>>(() async {
    await AppInitialization.initialize();
    runApp(const AcrovaApp());
  }, AppInitialization.logInitializationError);
}
