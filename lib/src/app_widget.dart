import 'package:flutter/material.dart';
import 'package:notebook/src/controllers/consumer_controller.dart';
import 'package:notebook/src/views/consumer_transactions_page.dart';
import 'package:provider/provider.dart';

import 'models/consumer_model.dart';
import 'views/home_page.dart';
import 'views/new_consumer_page.dart';

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
            '/add': (context) => SafeArea(child: NewConsumerPage()),
            '/consumerTransactionPage': (context) {
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
