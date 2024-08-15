import 'package:flutter/services.dart';

class EmojiRestrictingTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Regular expression to match emojis
    final regex = RegExp(
      r'[\u{1F600}-\u{1F64F}]|[\u{1F300}-\u{1F5FF}]|[\u{1F680}-\u{1F6FF}]|[\u{1F700}-\u{1F77F}]|[\u{1F780}-\u{1F7FF}]|[\u{1F800}-\u{1F8FF}]|[\u{1F900}-\u{1F9FF}]|[\u{1FA00}-\u{1FAFF}]|[\u{2600}-\u{26FF}]|[\u{2700}-\u{27BF}]',
      unicode: true,
    );

    String newText = newValue.text.replaceAll(regex, '');

    // Returning the filtered text value
    return newValue.copyWith(
        text: newText, selection: updateCursorPosition(newValue, newText));
  }

  // Method to maintain cursor position
  TextSelection updateCursorPosition(
      TextEditingValue newValue, String newText) {
    return TextSelection.collapsed(offset: newText.length);
  }
}
