
import 'package:flutter/material.dart';
import 'package:template_package/locale/translations.dart';


extension TranslationExtension on BuildContext {
  String translate(String key) {
    try {
      return Translations.of(this)!.text(key);
    } catch (e) {
      return key;
    }
  }
}