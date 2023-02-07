import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notebook/src/models/consumer_model.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.consumer.name),
      ),
      body: Center(child: Text(widget.consumer.toString())),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Valor"),
                  content: TextField(
                    decoration: const InputDecoration(hintText: "0,00"),
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      CurrencyTextInputFormatter(),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Confirmar"))
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final value = double.parse(newValue.text.replaceAll(',', '.')) * 0.01;
    final real =
        NumberFormat.currency(locale: 'pt_BR', decimalDigits: 2, name: '');
    final s = real.format(value);

    return TextEditingValue(
        text: s,
        selection: TextSelection.fromPosition(TextPosition(offset: s.length)));
  }
}
