import 'package:flutter/material.dart';
import 'package:flutter_app/provider/model/character.dart';
import 'package:flutter_app/provider/service/character_service.dart';
import 'package:flutter_app/widgets/character_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final TextEditingController searchTermController = TextEditingController();
  CharacterService characterService = CharacterService();
  List<Character>? _characters;
  bool isSearching = false;
  int numberOfCharacters = 0;

  @override
  void initState() {
    super.initState();
    _loadNumberOfCharacters();
  }

  _loadNumberOfCharacters() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      numberOfCharacters = prefs.getInt('numberOfCharacters') ?? 0;
    });
  }

  _saveNumberOfCharacters(int number) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('numberOfCharacters', number);
  }

  void onSearch(String name) async {
    setState(() {
      isSearching = true;
    });
    _characters = await characterService.getCharactersByName(name);
    setState(() {
      _characters = _characters;
      isSearching = false;
      numberOfCharacters = _characters!.length;
      _saveNumberOfCharacters(numberOfCharacters);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Find"),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Heroes: $numberOfCharacters',
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchTermController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search a character",
                  prefixIcon: Icon(Icons.search),
                ),
                onSubmitted: onSearch,
              ),
            ),
            Expanded(
              child: isSearching
                  ? const Center(child: CircularProgressIndicator())
                  : CharacterList(characters: _characters),
            )
          ],
        ),
      ),
    );
  }
}
