import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/operation_by_client_controller.dart';
import '../../../model/operation_model.dart';

class OperationAddPage extends StatefulWidget {
  const OperationAddPage(
      {super.key, required this.operationByClientController});
  final OperationByClientController operationByClientController;

  @override
  State<OperationAddPage> createState() => _OperationAddPageState();
}

class _OperationAddPageState extends State<OperationAddPage> {
  var transactionType = 1;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? valueStr;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New operation'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
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
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    formKey.currentState?.save();

                    final newOperation = OperationModel(
                      clientId: widget.operationByClientController.clientId,
                      datetime: DateTime.now(),
                      value: transactionType *
                          int.parse(
                              valueStr!.replaceAll(RegExp(r'(\.|,)'), '')),
                    );

                    widget.operationByClientController.save(newOperation);

                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Confirm'),
              )
            ],
          ),
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
