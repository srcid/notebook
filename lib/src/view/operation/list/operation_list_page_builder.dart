import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/operation_controller.dart';
import '../../../model/client_model.dart';
import 'operation_list_page.dart';

class OperationListPageBuilder extends StatelessWidget {
  const OperationListPageBuilder({super.key, required this.client});
  final ClientModel client;

  @override
  Widget build(BuildContext context) {
    final operationController = Provider.of<OperationController>(context);

    return Scaffold(
      body: FutureBuilder(
        future: operationController.getByClient(client),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final operations = snapshot.data!;
            return OperationListPage(client: client, operations: operations);
          }

          return Container();
        },
      ),
    );
  }
}
