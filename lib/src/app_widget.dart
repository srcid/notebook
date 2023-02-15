import 'package:flutter/material.dart';
import 'package:notebook/src/view/operation/add/client_add_page.dart';
import 'package:notebook/src/view/operation/list/extract_client.dart';
import 'package:provider/provider.dart';

import 'controller/client_controller.dart';
import 'view/client/list/clients_list_page.dart';

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
        },
      ),
    );
  }
}
