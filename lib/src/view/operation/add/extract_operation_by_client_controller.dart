import 'package:flutter/material.dart';

import '../../../controller/operation_by_client_controller.dart';
import 'operation_add.dart';

class ExtractOperationByClientController extends StatelessWidget {
  const ExtractOperationByClientController({super.key});

  @override
  Widget build(BuildContext context) {
    final operationByClientController = ModalRoute.of(context)!
        .settings
        .arguments as OperationByClientController;
    return OperationAddPage(
      operationByClientController: operationByClientController,
    );
  }
}
