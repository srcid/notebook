import 'package:flutter/material.dart';

import 'src/app_widget.dart';
import 'src/database/database_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseClient.instance.init();
  runApp(const AppWidget());
}
