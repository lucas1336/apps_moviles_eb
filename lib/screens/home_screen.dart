import 'package:flutter/material.dart';
import 'package:flutter_app/provider/model/character.dart';
import 'package:flutter_app/provider/service/character_service.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchTermController = TextEditingController();
  CharacterService characterService = CharacterService();
  List<Character>? _characters;
  bool isSearching = false;

  void onSearch(String name) async {
    setState(() {
      isSearching = true;
    });
    _characters = await characterService.getCharactersByName(name);
    setState(() {
      _characters = _characters;
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Superhero App'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.search),
                label: const Text('Find'),
                onPressed: () {
                  context.go('/list');
                },
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.favorite),
                label: const Text('Favorites'),
                onPressed: () {
                  context.go('/favorites');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
