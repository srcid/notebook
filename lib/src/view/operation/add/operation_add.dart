import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../../controller/operation_controller.dart';
import '../../../model/client_model.dart';
import '../../../model/operation_model.dart';
import '../../../util/operation_type.dart';
import 'util/currency_input_formatter.dart';

class OperationAddPage extends StatefulWidget {
  const OperationAddPage({super.key, required this.client});

  final ClientModel client;

  @override
  State<OperationAddPage> createState() => _OperationAddPageState();
}

class _OperationAddPageState extends State<OperationAddPage> {
  var operationType = OperationType.buy;
  final formKey = GlobalKey<FormState>();
  final operationController = GetIt.instance.get<OperationController>();
  String valueStr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova operação'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              RadioListTile(
                title: Text(OperationType.pay.title),
                value: OperationType.pay,
                groupValue: operationType,
                onChanged: (value) {
                  setState(() {
                    operationType = value!;
                  });
                },
              ),
              RadioListTile(
                title: Text(OperationType.buy.title),
                value: OperationType.buy,
                groupValue: operationType,
                onChanged: (value) {
                  setState(() {
                    operationType = value!;
                  });
                },
              ),
              const SizedBox(
                height: 32,
              ),
              TextFormField(
                autofocus: true,
                validator: (String? value) {
                  final currencyRegExp =
                      RegExp(r'[0-9]{1,3}(\.[0-9]{3})*,[0-9]{2}');
                  if (value == null) {
                    return 'Valor não pode ser nulo';
                  }
                  return currencyRegExp.hasMatch(value)
                      ? null
                      : 'Valor inválido';
                },
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
                    var value =
                        int.parse(valueStr.replaceAll(RegExp(r'(\.|,)'), ''));

                    if (operationType == OperationType.pay) {
                      value = -1 * value;
                    }

                    final newOperation = OperationModel(
                      clientId: widget.client.id!,
                      datetime: DateTime.now(),
                      value: value,
                    );

                    operationController.save(newOperation);

                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Confirmar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
