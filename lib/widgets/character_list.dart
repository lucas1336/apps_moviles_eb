import 'package:flutter/material.dart';
import 'package:flutter_app/persistence/repository/character_repository.dart';
import 'package:flutter_app/provider/model/character.dart';

class CharacterList extends StatefulWidget {
  final List<Character>? characters;

  const CharacterList({super.key, this.characters});

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  @override
  Widget build(BuildContext context) {
    if (widget.characters != null) {
      return ListView.builder(
        itemCount: widget.characters!.length,
        itemBuilder: (context, index) {
          final Character character = widget.characters![index];
          return CharacterCard(character: character);
        },
      );
    } else {
      return const Center(
        child: Text(
          'No characters found',
        ),
      );
    }
  }
}

class CharacterCard extends StatefulWidget {
  const CharacterCard({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  CharacterRepository characterRepository = CharacterRepository();
  late Character character;
  bool isFavorite = false;

  @override
  initState() {
    character = widget.character;
    _initialize();
    super.initState();
  }

  _initialize() async {
    final exist = await characterRepository.existById(widget.character.id);

    if (mounted) {
      setState(() {
        isFavorite = exist;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void handleToggleFavorite() {
      setState(() {
        isFavorite = !isFavorite;
      });
      isFavorite
          ? characterRepository.insert(character)
          : characterRepository.delete(character);
    }

    return ListTile(
      leading: Image.network(widget.character.image),
      title: Text(widget.character.name),
      subtitle: Row(
        children: [
          Text('Gender: ${widget.character.gender}'),
          const SizedBox(width: 10),
          Text('Intelligence: ${widget.character.intelligence}'),
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.favorite,
          color: isFavorite ? Colors.red : Colors.grey,
        ),
        onPressed: handleToggleFavorite,
      ),
    );
  }
}
