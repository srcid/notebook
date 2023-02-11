import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/consumer_model.dart';
import '../../../repository/consumer_repository.dart';

class ConsumerListTile extends StatefulWidget {
  final ConsumerModel consumer;
  final bool isSelected;
  final Function() onLongPress;

  const ConsumerListTile(
      {super.key,
      required this.consumer,
      required this.isSelected,
      required this.onLongPress});

  @override
  State<ConsumerListTile> createState() => _ConsumerListTileState();
}

class _ConsumerListTileState extends State<ConsumerListTile> {
  final rp = ConsumerRepository();

  @override
  Widget build(BuildContext context) {
    final real = NumberFormat.currency(
      locale: 'pt_BR',
      name: '',
      decimalDigits: 2,
    );
    final balanceStr = real.format(widget.consumer.balance * 0.01);
    final name = widget.consumer.name;
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      leading: CircleAvatar(
        child: Text(widget.consumer.name[0]),
      ),
      onLongPress: widget.onLongPress,
      onTap: () async {
        await Navigator.of(context).pushNamed(
          '/consumerTransaction',
          arguments: widget.consumer,
        );
        final updatedConsumer = await rp.findById(widget.consumer.id!);

        setState(() {
          widget.consumer.balance = updatedConsumer.balance;
        });
      },
      title: Text(name),
      subtitle: Text(balanceStr),
      selected: widget.isSelected,
    );
  }
}
