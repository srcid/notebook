import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/consumer_transaction_model.dart';
import '../../repository/consuemer_transaction_repository.dart';
import 'utils/currency_text_input_formatter.dart';

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
    String? valueStr;

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
              validator: (value) =>
                  RegExp(r'[0-9]{1,3}(\.[0-9]{3})*,[0-9]{2}').hasMatch(value!)
                      ? null
                      : 'Valor inválido',
              keyboardType: TextInputType.number,
              initialValue: '0,00',
              onSaved: (newValue) {
                valueStr = newValue!;
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
              onPressed: () async {
                if (formKey.currentState?.validate() ?? false) {
                  formKey.currentState?.save();

                  final newObj = ConsumerTransactionModel(
                    consumerId: consumerId,
                    datetime: DateTime.now(),
                    value: transactionType *
                        int.parse(valueStr!.replaceAll(RegExp(r'(\.|,)'), '')),
                  );

                  rp.add(newObj)
                    ..then((value) => null)
                    ..onError((error, stackTrace) => 1);

                  Navigator.of(context).pop();
                }
              },
              child: const Text('Confirmar'),
            )
          ],
        ),
      ),
    );
  }
}
