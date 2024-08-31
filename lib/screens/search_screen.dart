import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshin_impact/providers/character.dart';
import 'package:genshin_impact/services/characters.dart';
import 'package:genshin_impact/widgets/input.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  List<String> characters = [];
  List<String> filteredCharacters = [];
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getCharacters();

    controller.addListener(() {
      final text = controller.text;
      final filteredCharacters = characters
          .where(
              (element) => element.toLowerCase().contains(text.toLowerCase()))
          .toList();

      setState(() {
        this.filteredCharacters = filteredCharacters;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> getCharacters() async {
    final service = CharacterService();
    final characters = await service.getCharacters();
    setState(() {
      this.characters = characters;
    });
  }

  Future<void> getCharacter(context, String name) async {
    focusNode.unfocus();
    final service = CharacterService();
    final character = await service.getCharacter(name);
    if (character != null) {
      Provider.of<CharacterProvider>(context, listen: false)
          .setCharacter(character);
      Navigator.pushNamed(context, '/character');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('Genshin Impact Characters'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/paimon.png",
                  height: 230,
                ),
                const SizedBox(height: 16),
                Input(
                  focusNode: focusNode,
                  controller: controller,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCharacters.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(height: 8),
                          ListTile(
                            key: Key(filteredCharacters[index]),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            leading: CachedNetworkImage(
                              imageUrl:
                                  "https://genshin.jmp.blue/characters/${filteredCharacters[index]}/icon",
                              width: 48,
                            ),
                            title: Text(filteredCharacters[index]),
                            onTap: () async {
                              await getCharacter(
                                  context, filteredCharacters[index]);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
