import 'package:flutter/material.dart';

import 'theme/color_schemes.g.dart';
import 'model/client_model.dart';
import 'view/client/add/client_add_page.dart';
import 'view/client/list/clients_list_page.dart';
import 'view/operation/add/operation_add.dart';
import 'view/operation/list/operation_list_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        listTileTheme: ListTileThemeData(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          selectedColor: lightColorScheme.onBackground,
          selectedTileColor: lightColorScheme.onBackground.withOpacity(0.1),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      initialRoute: '/client/list',
      routes: {
        '/client/list': (context) => const ClientListPage(),
        '/client/add': (context) => const ClientAddPage(),
        '/operation/list': (context) {
          final client =
              ModalRoute.of(context)!.settings.arguments as ClientModel;
          return OperationListPage(client: client);
        },
        '/operation/add': (context) {
          final client =
              ModalRoute.of(context)!.settings.arguments as ClientModel;
          return OperationAddPage(client: client);
        },
      },
    );
  }
}
