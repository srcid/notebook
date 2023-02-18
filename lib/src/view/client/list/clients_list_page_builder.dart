import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/client_controller.dart';
import '../../../model/client_model.dart';
import 'client_list_page.dart';

class ClientListPageBuilder extends StatelessWidget {
  const ClientListPageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final clientController = Provider.of<ClientController>(context);

    return Scaffold(
      body: FutureBuilder(
        future: clientController.clients,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<ClientModel> clients = snapshot.data!;
            clients.sort(
              (a, b) => a.name.compareTo(b.name),
            );
            return ClientListPage(clients: clients);
          }
          return Container();
        },
      ),
    );
  }
}
