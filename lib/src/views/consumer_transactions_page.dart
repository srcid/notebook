import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:notebook/src/models/consumer_model.dart';
import 'package:notebook/src/repository/consuemer_transaction_repository.dart';

import '../models/consumer_transaction_model.dart';

class ConsumerTransactionPage extends StatefulWidget {
  final ConsumerModel consumer;

  const ConsumerTransactionPage({super.key, required this.consumer});

  @override
  State<ConsumerTransactionPage> createState() =>
      _ConsumerTransactionPageState();
}

class _ConsumerTransactionPageState extends State<ConsumerTransactionPage> {
  @override
  Widget build(BuildContext context) {
    final rp = ConsumerTransactionRepository();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.consumer.name),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/addConsumerTransaction',
              arguments: widget.consumer.id);

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: rp.findByConsumerId(widget.consumer.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text("No transaction yet"));
            }

            return ListConsumerTransactionWidget(
              transactions: snapshot.data!,
            );
          }

          return Container();
        },
      ),
    );
  }
}

class ListConsumerTransactionWidget extends StatelessWidget {
  final List<ConsumerTransactionModel> transactions;

  const ListConsumerTransactionWidget({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ConsumerTransactionCard(
            value: transaction.value, datetime: transaction.datetime);
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

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
