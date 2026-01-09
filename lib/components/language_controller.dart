
import 'package:flutter/material.dart';

class LanguageController extends ValueNotifier<bool> {
  LanguageController() : super(false);

  bool get isEnglish => value;

  void toggle() => value = !value;
}

final languageController = LanguageController();
