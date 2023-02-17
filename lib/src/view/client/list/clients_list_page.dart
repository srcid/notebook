import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../model/client_model.dart';
import '../../../repository/interface/client_repository.dart';

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
        title: const Text('Clientes'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
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
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: clients.length,
              separatorBuilder: (context, index) => const Divider(),
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
                  removeClient: () async {
                    await clientRepository.remove(client);
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
  const ClientListTile(
      {super.key,
      required this.client,
      required this.onTap,
      required this.removeClient});
  final ClientModel client;
  final Function()? onTap;
  final Function()? removeClient;

  @override
  Widget build(BuildContext context) {
    final real =
        NumberFormat.currency(locale: 'pt_BR', name: '', decimalDigits: 2);
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      leading: CircleAvatar(
        child: Text(client.name[0]),
      ),
      title: Text(client.name),
      subtitle: Text(real.format(client.balance * 0.01)),
      onTap: onTap,
      trailing: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem(
              child: Text('Editar'),
            ),
            PopupMenuItem(
              onTap: removeClient,
              child: const Text('Remover'),
            ),
          ];
        },
      ),
    );
  }
}
