import 'package:flutter/material.dart';
import '../controllers/consumer_controller.dart';

class NewConsumerPage extends StatelessWidget {
  NewConsumerPage({super.key});
  final _consumerController = ConsumerController.instance;
  final _textEditingController = TextEditingController();

  TextFormField customTextFormField(String fieldName, Icon prefixIcon) {
    return TextFormField(
      controller: _textEditingController,
      autofocus: true,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        border: const OutlineInputBorder(),
        label: Text(fieldName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cadastro'),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            customTextFormField('Nome', const Icon(Icons.person)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(50, 55)),
              onPressed: () {
                final name = _textEditingController.text.trim();
                _consumerController.add(name);
                Navigator.of(context).pop();
              },
              child: const Text(
                "Adicionar",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            OutlinedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red, minimumSize: const Size(50, 55)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancelar",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
