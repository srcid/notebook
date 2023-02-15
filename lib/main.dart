import 'package:flutter/material.dart';
import 'package:notebook/src/app_widget.dart';
import 'package:notebook/src/database/database_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseClient.instance.init();
  runApp(const AppWidget());
}
