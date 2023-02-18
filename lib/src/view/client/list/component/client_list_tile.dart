import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../controller/client_controller.dart';
import '../../../../model/client_model.dart';

class ClientListTile extends StatelessWidget {
  const ClientListTile({super.key, required this.client});
  final ClientModel client;

  String formatCurrency(num number) =>
      NumberFormat.currency(locale: 'pt_BR', name: '', decimalDigits: 2)
          .format(number * 0.01);

  @override
  Widget build(BuildContext context) {
    final clientController =
        Provider.of<ClientController>(context, listen: false);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        child: Text(client.name[0]),
      ),
      title: Text(client.name),
      subtitle: Text(formatCurrency(client.balance)),
      onTap: () =>
          Navigator.of(context).pushNamed('/operation/list', arguments: client),
      trailing: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem(
              child: Text('Editar'),
            ),
            PopupMenuItem(
              onTap: () => clientController.remove(client),
              child: const Text('Remover'),
            ),
          ];
        },
      ),
    );
  }
}
