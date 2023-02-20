import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../model/client_model.dart';
import 'client_popup_menu_button.dart';

class ClientListTile extends StatelessWidget {
  const ClientListTile({super.key, required this.client});
  final ClientModel client;

  String formatCurrency(num number) {
    return NumberFormat.currency(locale: 'pt_BR', name: '', decimalDigits: 2)
          .format(number * 0.01);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        child: Text(client.name[0]),
      ),
      title: Text(client.name),
      subtitle: Text(formatCurrency(client.balance)),
      onTap: () {
        Navigator.of(context).pushNamed('/operation/list', arguments: client);
      },
      trailing: ClientPopupMenuButton(client: client),
    );
  }
}
