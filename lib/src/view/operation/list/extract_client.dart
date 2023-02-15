import 'package:flutter/material.dart';
import 'package:notebook/src/controller/operation_by_client_controller.dart';
import 'package:provider/provider.dart';

import '../../../model/client_model.dart';
import 'operation_list_page.dart';

class ExtractClient extends StatelessWidget {
  const ExtractClient({super.key});

  @override
  Widget build(BuildContext context) {
    final client = ModalRoute.of(context)!.settings.arguments as ClientModel;
    return ChangeNotifierProvider(
      create: (context) => OperationByClientController(clientId: client.id!),
      child: OperationListPage(client: client),
    );
  }
}
