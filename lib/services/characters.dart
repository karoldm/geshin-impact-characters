import 'package:dio/dio.dart';
import 'package:genshin_impact/models/character.dart';

class CharacterService {
  final dio = Dio(BaseOptions(baseUrl: "https://genshin.jmp.blue/"));

  Future<List<String>> getCharacters() async {
    try {
      final response = await dio.get('/characters');
      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List<dynamic>)
              .map((e) => e.toString())
              .toList();
        } else {
          throw Exception('Data format is not a List');
        }
      }
      return [];
    } catch (error) {
      rethrow;
    }
  }

  Future<Character?> getCharacter(String name) async {
    try {
      final response = await dio.get('/characters/$name');
      if (response.statusCode == 200) {
        return Character.fromJson(response.data);
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }
}
