import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsumerTransactionCard extends StatelessWidget {
  final int value;
  final DateTime datetime;

  const ConsumerTransactionCard({
    super.key,
    required this.value,
    required this.datetime,
  });

  @override
  Widget build(BuildContext context) {
    final realFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      name: '',
      decimalDigits: 2,
    );
    final dateFormatter = DateFormat(r'dd/MM/y HH:mm');
    final text = value < 0 ? 'Pagamento' : 'Compra';
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
    final valueFormatted = realFormatter.format(value * 0.01);
    final dateFormatted = dateFormatter.format(datetime);

    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: icon,
            ),
            Text(text),
            Text(valueFormatted),
            Text(dateFormatted),
            const Icon(Icons.more_vert)
          ],
        ),
      ),
    );
  }
}
