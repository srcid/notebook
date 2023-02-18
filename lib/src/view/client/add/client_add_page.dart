import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../controller/client_controller.dart';
import '../../../model/client_model.dart';

class ClientAddPage extends StatefulWidget {
  const ClientAddPage({super.key});

  @override
  State<ClientAddPage> createState() => _ClientAddPageState();
}

class _ClientAddPageState extends State<ClientAddPage> {
  final form = GlobalKey<FormState>();
  final clientController = GetIt.instance.get<ClientController>();
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Form(
          key: form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                validator: (String? value) {
                  final pattern = RegExp(
                    r'^\p{L}+( \p{L}+)*$',
                    caseSensitive: false,
                    unicode: true,
                  );

                  if (value != null && pattern.hasMatch(value.trim())) {
                    return null;
                  }
                  return 'Nome inválido';
                },
                onSaved: (String? newValue) {
                  name = newValue!;
                },
                autofocus: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  label: Text('Nome'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (form.currentState?.validate() ?? false) {
                        form.currentState?.save();
                        final newClient =
                            ClientModel(name: name.trim().toUpperCase());
                        clientController.save(newClient);
                        Navigator.of(context).pop<bool>(true);
                      }
                    },
                    child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Salvar')),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop<bool>(false);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Cancelar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
