import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../model/client_model.dart';
import '../../../repository/interface/operation_repository.dart';

class OperationListPage extends StatefulWidget {
  const OperationListPage({super.key, required this.client});
  final ClientModel client;

  @override
  State<OperationListPage> createState() => _OperationListPageState();
}

class _OperationListPageState extends State<OperationListPage> {
  final OperationRepository operationRepository =
      GetIt.instance.get<OperationRepository>();

  Future<bool> deleteConfirmationDialog(BuildContext context) async =>
      await showDialog(
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
                child: Text('Nenhuma movimentação'),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 64),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: operations.length,
                itemBuilder: (context, index) {
                  final operation = operations[index];
                  return OperationListTile(
                    value: operation.value,
                    datetime: operation.datetime,
                    removeOperation: () async {
                      if (await deleteConfirmationDialog(context)) {
                        await operationRepository.remove(operation);
                        setState(() {});
                      }
                    },
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
  const OperationListTile({
    super.key,
    required this.value,
    required this.datetime,
    required this.removeOperation,
  });

  final int value;
  final DateTime datetime;
  final Function()? removeOperation;

  @override
  Widget build(BuildContext context) {
    final realFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      name: '',
      decimalDigits: 2,
    );
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
    final dateFormatted = timeago.format(datetime, locale: 'pt_BR_short');

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: icon,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(text), Text(dateFormatted)],
      ),
      subtitle: Text(valueFormatted),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: removeOperation,
      ),
    );
  }
}
