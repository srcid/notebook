import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notebook/src/models/consumer_transaction_model.dart';
import 'package:notebook/src/repository/consuemer_transaction_repository.dart';

class NewConsumerTransactionPage extends StatefulWidget {
  final int consumerId;
  const NewConsumerTransactionPage({super.key, required this.consumerId});

  @override
  State<NewConsumerTransactionPage> createState() =>
      _NewConsumerTransactionPageState();
}

class _NewConsumerTransactionPageState
    extends State<NewConsumerTransactionPage> {
  var transactionType = 1;
  final formKey = GlobalKey<FormState>();
  final rp = ConsumerTransactionRepository();

  @override
  Widget build(BuildContext context) {
    final consumerId = widget.consumerId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Transação'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            RadioListTile<int>(
              title: const Text('Pagamento'),
              value: -1,
              groupValue: transactionType,
              onChanged: (value) {
                setState(() {
                  transactionType = value!;
                });
              },
            ),
            RadioListTile(
              title: const Text('Compra'),
              value: 1,
              groupValue: transactionType,
              onChanged: (value) {
                setState(() {
                  transactionType = value!;
                });
              },
            ),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              autofocus: true,
              keyboardType: TextInputType.number,
              initialValue: '0,00',
              onSaved: (newValue) async {
                final newObj = ConsumerTransactionModel(
                  consumerId: consumerId,
                  datetime: DateTime.now(),
                  value: transactionType *
                      int.parse(newValue!.replaceAll(RegExp(r'(\.|,)'), '')),
                );

                print(await rp.add(newObj));
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.payment),
                border: OutlineInputBorder(),
                label: Text('Valor'),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                CurrencyTextInputFormatter(),
              ],
            ),
            const SizedBox(
              height: 42,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () {
                formKey.currentState?.save();
                Navigator.of(context).pop();
              },
              child: const Text('Confirmar'),
            )
          ],
        ),
      ),
    );
  }
}

class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final real = NumberFormat.currency(
      locale: 'pt_BR',
      name: '',
      decimalDigits: 2,
    );

    final oldValueDouble = double.parse(newValue.text) * 0.01;
    final newValueFormatted = real.format(oldValueDouble);

    return TextEditingValue(
      text: newValueFormatted,
      selection: TextSelection.fromPosition(
        TextPosition(
          offset: newValueFormatted.length,
        ),
      ),
    );
  }
}
