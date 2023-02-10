import 'package:flutter/material.dart';
import 'package:notebook/src/controllers/consumer_controller.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as dev;

class NewConsumerPage extends StatelessWidget {
  NewConsumerPage({super.key});
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cadastro'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Form(
            key: formkey,
            child: const CustomTextFormField(
              fieldName: 'Nome',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          addButton(context),
          const SizedBox(
            height: 16,
          ),
          removeButton(context),
        ],
      ),
    );
  }

  OutlinedButton removeButton(BuildContext context) {
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.red, minimumSize: const Size(50, 55)),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text(
        "Cancelar",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  ElevatedButton addButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: const Size(50, 55)),
      onPressed: () {
        if (formkey.currentState?.validate() ?? false) {
          formkey.currentState?.save();
          Navigator.of(context).pop();
        }
      },
      child: const Text(
        "Adicionar",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key, required this.fieldName, required this.prefixIcon});
  final String fieldName;
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        final pattern = RegExp(
          r'^\p{L}+( \p{L}+)*$',
          caseSensitive: false,
          unicode: true,
        );
        dev.log('"${value}"', name: 'validate');
        if (value != null && pattern.hasMatch(value)) {
          return null;
        }
        return 'Entrada invalida';
      },
      onSaved: (String? newValue) {
        final consumerController =
            Provider.of<ConsumerController>(context, listen: false);
        final String name = newValue!.trim().toUpperCase();
        consumerController.add(name);
      },
      autofocus: true,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        border: const OutlineInputBorder(),
        label: Text(fieldName),
      ),
    );
  }
}
