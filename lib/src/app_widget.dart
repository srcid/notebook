import 'package:flutter/material.dart';
import 'package:notebook/src/controllers/consumer_controller.dart';
import 'package:provider/provider.dart';

import 'models/consumer_model.dart';
import 'views/add_consumer/new_consumer_page.dart';
import 'views/list_consumer_transactions/consumer_transactions_page.dart';
import 'views/list_consumers/home_page.dart';
import 'views/add_consumer_transaction/new_consumer_transaction_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConsumerController>(
          create: (context) => ConsumerController(),
        )
      ],
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (context) => const SafeArea(child: HomePage()),
            '/consumer/add': (context) => SafeArea(child: NewConsumerPage()),
            '/consumerTransaction/add': (context) {
              final int consumerId =
                  (ModalRoute.of(context)!.settings.arguments as int);
              return SafeArea(
                  child: NewConsumerTransactionPage(
                consumerId: consumerId,
              ));
            },
            '/consumerTransaction': (context) {
              final consumer =
                  (ModalRoute.of(context)!.settings.arguments as ConsumerModel);

              return SafeArea(
                  child: ConsumerTransactionPage(
                consumer: consumer,
              ));
            },
          },
          initialRoute: '/',
        );
      },
    );
  }
}
