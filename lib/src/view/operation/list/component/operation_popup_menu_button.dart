import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;

import '../../../../controller/operation_controller.dart';
import '../../../../model/operation_model.dart';
import '../../../../util/popup_menu_option.dart';

class OperationPopupMenuButton extends StatelessWidget {
  const OperationPopupMenuButton({super.key, required this.operation});

  final OperationModel operation;

  @override
  Widget build(BuildContext context) {
    final operationController =
        Provider.of<OperationController>(context, listen: false);
    return PopupMenuButton<PopupMenuOption>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        switch (value) {
          case PopupMenuOption.edit:
            dev.log('Não implementado');
            break;
          case PopupMenuOption.remove:
            deleteConfirmationDialog(context).then((value) {
              if (value ?? false) {
                operationController.remove(operation);
              }
            });
            break;
        }
      },
      itemBuilder: itemBuilder,
    );
  }

  List<PopupMenuEntry<PopupMenuOption>> itemBuilder(BuildContext context) {
    final popupEntries = [
      PopupMenuItem<PopupMenuOption>(
        value: PopupMenuOption.edit,
        child: Text(PopupMenuOption.edit.title),
      ),
      PopupMenuItem(
        value: PopupMenuOption.remove,
        child: Text(PopupMenuOption.remove.title),
      ),
    ];
    return popupEntries;
  }

  Future<bool?> deleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Aviso'),
          content: const Text('Deseja remover essa operação?'),
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
