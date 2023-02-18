import 'package:flutter/material.dart';

import '../../../model/client_model.dart';
import '../../../model/operation_model.dart';
import 'component/operation_list_tile.dart';

class OperationListPage extends StatelessWidget {
  const OperationListPage(
      {super.key, required this.client, required this.operations});
  final ClientModel client;
  final List<OperationModel> operations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(client.name),
      ),
      body: Visibility(
        visible: operations.isNotEmpty,
        replacement: const Center(child: Text('Nenhuma operação')),
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 64),
          itemBuilder: (context, index) {
            final operation = operations[index];
            return OperationListTile(
              operation: operation,
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: operations.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.of(context).pushNamed(
            '/operation/add',
            arguments: client,
          );
        },
      ),
    );
  }
}
