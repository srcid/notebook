import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../model/operation_model.dart';
import 'operation_popup_menu_button.dart';

class OperationListTile extends StatelessWidget {
  const OperationListTile({super.key, required this.operation});

  final OperationModel operation;

  @override
  Widget build(BuildContext context) {
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
      trailing: OperationPopupMenuButton(
        operation: operation,
      ),
    );
  }
}
