import 'package:flutter/foundation.dart';
import '../repository/consumer_repository.dart';
import '../models/consumer_model.dart';

class ConsumerController extends ChangeNotifier {
  final _consumers = <ConsumerModel>[];
  final _consumersRepository = ConsumerRepository();

  List<ConsumerModel> get consumers => _consumers;

  ConsumerController() {
    _init();
  }

  _init() async {
    await _consumersRepository.findAll().then((value) {
      _consumers.addAll(value);
      notifyListeners();
    });
  }

  add(String name) {
    final newObj = ConsumerModel(null, name: name);
    _consumersRepository.add(newObj).then((value) {
      newObj.id = value;
      _consumers.add(newObj);
      notifyListeners();
    });
  }
}
