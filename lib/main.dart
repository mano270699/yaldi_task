import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'core/base/dependency_injection.dart' as di;
import 'core/base/main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await di.init();

  runApp(MainApp());
}
