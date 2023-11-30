import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/provider/model/character.dart';
import 'package:http/http.dart' as http;

class CharacterService {
  final String baseUrl = "https://superheroapi.com/api/316850321281343";

  Future<List<Character>> getCharactersByName(String name) async {
    final http.Response response =
        await http.get(Uri.parse('$baseUrl/search/$name'));

    if (response.statusCode != HttpStatus.ok) {
      return [];
    }

    final jsonResponse = json.decode(response.body);
    final List characters = jsonResponse['results'];

    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
