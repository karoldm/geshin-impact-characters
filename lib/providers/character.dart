import 'package:flutter/material.dart';
import 'package:genshin_impact/models/character.dart';

class CharacterProvider with ChangeNotifier {
  Character? _character;

  Character? get character => _character;

  void setCharacter(Character character) {
    _character = character;
    notifyListeners();
  }
}
