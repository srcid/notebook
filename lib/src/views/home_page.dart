import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:notebook/src/views/consumer_transactions_page.dart';
import 'package:provider/provider.dart';
import '../controllers/consumer_controller.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _consumersSelected = List<bool>.filled(9999, false);
  final _real = NumberFormat.currency(
    locale: 'pt_BR',
    name: '',
    decimalDigits: 2,
  );

  @override
  Widget build(BuildContext context) {
    final consumerController = Provider.of<ConsumerController>(context);
    final consumers = consumerController.consumers;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Clientes"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/add');
              },
              icon: const Icon(Icons.person_add)),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        separatorBuilder: (context, index) => const Divider(height: 16),
        itemBuilder: itemBuilder,
        itemCount: consumers.length,
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final consumerController = Provider.of<ConsumerController>(context);
    final consumer = consumerController.consumers[index];
    final balanceStr = _real.format(consumer.balance * 0.01);
    final name = consumer.name;

    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      leading: CircleAvatar(
        child: Text(name[0]),
      ),
      onLongPress: () {
        setState(() {
          _consumersSelected[index] = !_consumersSelected[index];
        });
      },
      onTap: () {
        Navigator.of(context)
            .pushNamed('/consumerTransactionPage', arguments: consumer);
      },
      title: Text(name),
      subtitle: Text(balanceStr),
      selected: _consumersSelected[index],
      selectedTileColor: Colors.blueGrey[100],
    );
  }
}
