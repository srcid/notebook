import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:notebook/src/repository/interface/client_repository.dart';

import '../../../model/client_model.dart';

class ClientListPage extends StatefulWidget {
  const ClientListPage({super.key});

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  final clientRepository = GetIt.instance.get<ClientRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.of(context).pushNamed('/client/add');
              setState(() {});
            },
            icon: const Icon(Icons.person_add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: clientRepository.findAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final clients = snapshot.data!;
            clients.sort(
              (a, b) => a.name.compareTo(b.name),
            );
            return ListView.builder(
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients[index];
                return ClientListTile(
                  client: client,
                  onTap: () async {
                    await Navigator.of(context).pushNamed(
                      '/operation/list',
                      arguments: client,
                    );
                    setState(() {});
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}

class ClientListTile extends StatelessWidget {
  const ClientListTile({super.key, required this.client, required this.onTap});
  final ClientModel client;
  final Function()? onTap;

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
      onTap: onTap,
    );
  }
}
