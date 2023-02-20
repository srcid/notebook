import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../controller/operation_controller.dart';
import '../../../../model/operation_model.dart';

class OperationListTile extends StatelessWidget {
  const OperationListTile({super.key, required this.operation});

  final OperationModel operation;

  @override
  Widget build(BuildContext context) {
    final operationController =
        Provider.of<OperationController>(context, listen: false);
    final realFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      name: '',
      decimalDigits: 2,
    );

    final title =
        operation.value < 0 ? 'Pagamento realizado' : 'Compra realizada';
    final color = operation.value < 0 ? Colors.green : Colors.red;
    final icon = Icon(operation.value < 0 ? Icons.payment : Icons.shopping_cart,
        color: color);

    final valueFormatted = realFormatter.format(operation.value.abs() * 0.01);
    final dateFormatted =
        timeago.format(operation.datetime, locale: 'pt_BR_short');

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: icon,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(dateFormatted)],
      ),
      subtitle: Text(valueFormatted),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          deleteConfirmationDialog(context).then((value) {
            if (value ?? false) {
              operationController.remove(operation);
            }
          });
        },
      ),
    );
  }

  Future<bool?> deleteConfirmationDialog(BuildContext context) async =>
      await showDialog<bool?>(
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
