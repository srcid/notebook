import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/consumer_controller.dart';
import 'widgets/consumer_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _consumersSelected = List<bool>.filled(9999, false);

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
                Navigator.of(context).pushNamed('/consumer/add');
              },
              icon: const Icon(Icons.person_add)),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        separatorBuilder: (context, index) => const Divider(height: 16),
        itemBuilder: (context, index) => ConsumerListTile(
          consumer: consumers[index],
          isSelected: _consumersSelected[index],
          onLongPress: () {
            setState(() {
              _consumersSelected[index] = !_consumersSelected[index];
            });
          },
        ),
        itemCount: consumers.length,
      ),
    );
  }
}
