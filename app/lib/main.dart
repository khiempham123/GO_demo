import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app_dependencies/app_dependencies.dart';

void main() {
  AppDependencies.initial();
  runApp(const MyApp());
}
