import 'package:flutter/foundation.dart';
import '../repository/consumer_repository.dart';
import '../models/consumer.dart';

class ConsumerController extends ChangeNotifier {
  ConsumerController._internal() {
    _init();
  }

  static final instance = ConsumerController._internal();

  final _consumers = <Consumer>[];
  final _consumersRepository = ConsumerRepository();

  List<Consumer> get consumers => _consumers;

  _init() {
    _consumersRepository.findAll().then((value) {
      _consumers.addAll(value);
      notifyListeners();
    });
  }

  add(String name) {
    final newObj = Consumer(null, name: name);
    _consumersRepository.add(newObj).then((value) {
      newObj.id = value;
      _consumers.add(newObj);
      notifyListeners();
    });
  }
}
