import 'package:flutter/material.dart';

import '../../../model/client_model.dart';
import 'component/client_list_tile.dart';

class ClientListPage extends StatelessWidget {
  const ClientListPage({super.key, required this.clients});
  final List<ClientModel> clients;

  @override
  Widget build(BuildContext context) {
    final itemCount = clients.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/client/add');
            },
            icon: const Icon(Icons.person_add),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final client = clients[index];
          return ClientListTile(client: client);
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: itemCount,
      ),
    );
  }
}
