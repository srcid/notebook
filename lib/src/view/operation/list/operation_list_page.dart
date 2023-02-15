import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notebook/src/repository/interface/operation_repository.dart';
import 'package:notebook/src/repository/sqlite/operation_repository_sqlite.dart';

import '../../../model/client_model.dart';

class OperationListPage extends StatefulWidget {
  const OperationListPage({super.key, required this.client});
  final ClientModel client;

  @override
  State<OperationListPage> createState() => _OperationListPageState();
}

class _OperationListPageState extends State<OperationListPage> {
  final OperationRepository operationRepository = OperationRepositorySQLite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.client.name),
      ),
      body: FutureBuilder(
        future: operationRepository
            .findByClientIdOrderByDatetime(widget.client.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final operations = snapshot.data!;

            return Visibility(
              visible: operations.isNotEmpty,
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
            );
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).pushNamed(
            '/operation/add',
            arguments: widget.client,
          );
          setState(() {});
        },
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
