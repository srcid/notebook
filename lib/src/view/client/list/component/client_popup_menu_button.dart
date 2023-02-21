import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/client_controller.dart';
import '../../../../model/client_model.dart';
import '../../../../util/popup_menu_option.dart';

class ClientPopupMenuButton extends StatelessWidget {
  const ClientPopupMenuButton({
    super.key,
    required this.client,
  });

  final ClientModel client;

  @override
  Widget build(BuildContext context) {
    final clientController =
        Provider.of<ClientController>(context, listen: false);
    return PopupMenuButton<PopupMenuOption>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        switch (value) {
          case PopupMenuOption.edit:
            Navigator.of(context).pushNamed('/client/add', arguments: client);
            break;

          case PopupMenuOption.remove:
            deleteConfirmationDialog(context).then((value) {
              if (value ?? false) {
                clientController.remove(client);
              }
            });
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: PopupMenuOption.edit,
            child: Text(PopupMenuOption.edit.title),
          ),
          PopupMenuItem(
            value: PopupMenuOption.remove,
            child: Text(PopupMenuOption.remove.title),
          ),
        ];
      },
    );
  }

  Future<bool?> deleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Aviso'),
          content: const Text('Deseja remover esse cliente?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Não',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
