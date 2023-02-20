import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final real = NumberFormat.currency(
      locale: 'pt_BR',
      name: '',
      decimalDigits: 2,
    );

    final newValueInt = int.parse(newValue.text) * 0.01;
    final newValueFormatted = real.format(newValueInt);

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
