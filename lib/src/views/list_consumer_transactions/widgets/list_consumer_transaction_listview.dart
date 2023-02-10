import 'package:flutter/material.dart';
import 'package:notebook/src/models/consumer_transaction_model.dart';

import 'consumer_transaction_card.dart';

class ListConsumerTransactionListView extends StatelessWidget {
  final List<ConsumerTransactionModel> transactions;

  const ListConsumerTransactionListView({
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
