import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'src/controller/client_controller.dart';
import 'src/controller/operation_controller.dart';
import 'src/repository/interface/client_repository.dart';
import 'src/repository/interface/operation_repository.dart';
import 'src/repository/sqlite/client_repository_sqlite.dart';
import 'src/repository/sqlite/operation_repository_sqlite.dart';
import 'src/app_widget.dart';
import 'src/database/database_client.dart';

setup() {
  GetIt.instance
      .registerFactory<ClientRepository>(() => ClientRepositorySQLite());
  GetIt.instance
      .registerFactory<OperationRepository>(() => OperationRepositorySQLite());
  GetIt.I.registerSingleton(ClientController());
  GetIt.I.registerSingleton(OperationController());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseClient.instance.init();
  setup();
  timeago.setLocaleMessages('pt_BR_short', timeago.PtBrShortMessages());
  runApp(const AppWidget());
}
