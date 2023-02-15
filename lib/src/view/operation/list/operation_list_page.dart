import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/operation_by_client_controller.dart';
import '../../../model/client_model.dart';

class OperationListPage extends StatelessWidget {
  const OperationListPage({super.key, required this.client});
  final ClientModel client;
  @override
  Widget build(BuildContext context) {
    final operationController = context.watch<OperationByClientController>();
    final operations = operationController.operations;

    return Scaffold(
      appBar: AppBar(
        title: Text(client.name),
      ),
      body: Visibility(
        visible: operations.length > 0,
        replacement: const Center(
          child: Text('No operation yet'),
        ),
        child: ListView.builder(
          itemCount: operations.length,
          itemBuilder: (context, index) {
            final operation = operations[index];
            return OperationListTile(
              value: operation.value,
              datetime: operation.datetime,
            );
          },
        ),
      ),
    );
  }
}

class OperationListTile extends StatelessWidget {
  const OperationListTile(
      {super.key, required this.value, required this.datetime});
  final int value;
  final DateTime datetime;
  @override
  Widget build(BuildContext context) {
    final realFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      name: '',
      decimalDigits: 2,
    );
    final dateFormatter = DateFormat(r'dd/MM/y HH:mm:ss');
    final text = value < 0 ? 'Pagamento realizado' : 'Compra realizada';
    final color = value < 0 ? Colors.green[100] : Colors.red[100];
    final icon = value < 0
        ? const Icon(
            Icons.payment,
            color: Colors.green,
          )
        : const Icon(
            Icons.shopping_cart,
            color: Colors.red,
          );
    final valueFormatted = realFormatter.format(value.abs() * 0.01);
    final dateFormatted = dateFormatter.format(datetime);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: icon,
      ),
      title: Text(text),
      subtitle: Text(valueFormatted),
      trailing: Text(dateFormatted),
    );
  }
}
