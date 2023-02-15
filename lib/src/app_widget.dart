import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/client_controller.dart';
import 'view/client/add/client_add_page.dart';
import 'view/client/list/clients_list_page.dart';
import 'view/operation/add/extract_operation_by_client_controller.dart';
import 'view/operation/list/extract_client.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClientController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          listTileTheme: ListTileThemeData(
            selectedColor: Colors.black,
            selectedTileColor: Colors.blueGrey[100],
          ),
        ),
        initialRoute: '/client/list',
        routes: {
          '/client/list': (context) => const ClientListPage(),
          '/client/add': (context) => const ClientAddPage(),
          '/operation/list': (context) => const ExtractClient(),
          '/operation/add': (context) =>
              const ExtractOperationByClientController(),
        },
      ),
    );
  }
}
