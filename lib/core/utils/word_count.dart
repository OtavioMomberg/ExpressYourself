import 'package:material_ui/material_ui.dart';

final class WordCount._() {
  final _word = ValueNotifier<int>(0);

  static final _instance = WordCount._();
  factory instance() => _instance;

  ValueNotifier<int> get word => _word;

  void resetWordNumber() => _word.value = 0;

  void changeValue({required int newValue}) => _word.value = newValue;

  ValueNotifier<int> disposeWordNotifier() => _word;
}
