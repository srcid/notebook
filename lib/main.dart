import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notebook/src/repository/interface/client_repository.dart';
import 'package:notebook/src/repository/interface/operation_repository.dart';
import 'package:notebook/src/repository/sqlite/client_repository_sqlite.dart';
import 'package:notebook/src/repository/sqlite/operation_repository_sqlite.dart';

import 'src/app_widget.dart';
import 'src/database/database_client.dart';

setup() {
  GetIt.instance
      .registerFactory<ClientRepository>(() => ClientRepositorySQLite());
  GetIt.instance
      .registerFactory<OperationRepository>(() => OperationRepositorySQLite());
}

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseClient.instance.init();
  runApp(const AppWidget());
}
