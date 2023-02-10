import 'package:flutter/material.dart';
import 'package:notebook/src/models/consumer_model.dart';
import 'package:notebook/src/repository/consuemer_transaction_repository.dart';

import 'widgets/list_consumer_transaction_listview.dart';

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
          await Navigator.of(context).pushNamed('/consumerTransaction/add',
              arguments: widget.consumer.id);

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: rp.findByConsumerIdOrdered(widget.consumer.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text("No transaction yet"));
            }

            return ListConsumerTransactionListView(
              transactions: snapshot.data!,
            );
          }

          return Container();
        },
      ),
    );
  }
}
