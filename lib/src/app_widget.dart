import 'package:flutter/material.dart';
import 'package:notebook/src/views/consumer_transactions_page.dart';

import 'models/consumer.dart';
import 'views/home_page.dart';
import 'views/new_consumer_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const SafeArea(child: HomePage()),
        '/add': (context) => SafeArea(child: NewConsumerPage()),
        '/consumerTransactionPage': (context) {
          final consumer =
              ModalRoute.of(context)!.settings.arguments as Consumer;
          return SafeArea(
              child: ConsumerTransactionPage(
            consumer: consumer,
          ));
        },
      },
      initialRoute: '/',
    );
  }
}
