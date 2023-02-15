import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notebook/src/model/client_model.dart';
import 'package:provider/provider.dart';

import '../../../controller/client_controller.dart';

class ClientListPage extends StatelessWidget {
  const ClientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clientController = context.watch<ClientController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/client/add');
            },
            icon: const Icon(Icons.person_add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: clientController.clients.length,
        itemBuilder: (context, index) {
          final client = clientController.clients[index];
          return ClientListTile(client: client);
        },
      ),
    );
  }
}

class ClientListTile extends StatelessWidget {
  const ClientListTile({super.key, required this.client});
  final ClientModel client;
  @override
  Widget build(BuildContext context) {
    final real =
        NumberFormat.currency(locale: 'pt_BR', name: '', decimalDigits: 2);
    return ListTile(
      leading: CircleAvatar(
        child: Text(client.name[0]),
      ),
      title: Text(client.name),
      subtitle: Text(real.format(client.balance * 0.01)),
      onTap: () {
        Navigator.of(context).pushNamed('/operation/list', arguments: client);
      },
    );
  }
}
