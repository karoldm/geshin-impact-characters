import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genshin_impact/models/character.dart';
import 'package:genshin_impact/providers/character.dart';
import 'package:genshin_impact/widgets/rarity.dart';
import 'package:provider/provider.dart';

enum Weapon {
  bow('https://genshin.jmp.blue/weapons/blackcliff-warbow/icon'), // arco
  catalyst(
      'https://genshin.jmp.blue/weapons/blackcliff-agate/icon'), // catalisador
  claymore(
      'https://genshin.jmp.blue/weapons/blackcliff-slasher/icon'), // espadão
  polearm('https://genshin.jmp.blue/weapons/blackcliff-pole/icon'), // lança
  sword('https://genshin.jmp.blue/weapons/blackcliff-longsword/icon'); // espada

  final String icon;
  const Weapon(this.icon);

  static String getWeaponIcon(String weapon) {
    switch (weapon) {
      case 'bow':
        return Weapon.bow.icon;
      case 'catalyst':
        return Weapon.catalyst.icon;
      case 'claymore':
        return Weapon.claymore.icon;
      case 'polearm':
        return Weapon.polearm.icon;
      case 'sword':
        return Weapon.sword.icon;
      default:
        return Weapon.sword.icon;
    }
  }
}

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  Character? character;

  @override
  void initState() {
    super.initState();
    setState(() {
      character =
          Provider.of<CharacterProvider>(context, listen: false).character;
    });
  }

  @override
  Widget build(BuildContext context) {
    return character != null
        ? Scaffold(
            backgroundColor: const Color(0xFFF8F8F8),
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 18,
                    color: Colors.white,
                  )),
              centerTitle: true,
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(character!.name),
            ),
            body: Column(
              children: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  imageUrl:
                      "https://genshin.jmp.blue/characters/${character!.id}/gacha-splash",
                  errorWidget: (context, url, error) => CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          "https://genshin.jmp.blue/characters/${character!.id}/icon-big"),
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                "https://genshin.jmp.blue/characters/${character!.id}/namecard-background",
                              ),
                              fit: BoxFit.cover,
                              alignment: Alignment.center),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              character!.title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Rarity(rarity: character!.rarity),
                            Text(
                              character!.description,
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    CachedNetworkImage(
                                      width: 40,
                                      height: 40,
                                      imageUrl:
                                          "https://genshin.jmp.blue/elements/${character!.vision.toLowerCase()}/icon",
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      character!.vision,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CachedNetworkImage(
                                      width: 40,
                                      height: 40,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.question_mark,
                                              color: Colors.white, size: 40),
                                      imageUrl:
                                          "https://genshin.jmp.blue/nations/${character!.nation.toLowerCase()}/icon",
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      character!.nation,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CachedNetworkImage(
                                      width: 40,
                                      height: 40,
                                      imageUrl: Weapon.getWeaponIcon(
                                          character!.weapon.toLowerCase()),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      character!.weapon,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        "https://genshin.jmp.blue/characters/${character!.id}/talent-burst",
                                      ),
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        "https://genshin.jmp.blue/characters/${character!.id}/talent-na",
                                      ),
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        "https://genshin.jmp.blue/characters/${character!.id}/talent-passive-0",
                                      ),
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        "https://genshin.jmp.blue/characters/${character!.id}/talent-passive-1",
                                      ),
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        "https://genshin.jmp.blue/characters/${character!.id}/talent-passive-2",
                                      ),
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        "https://genshin.jmp.blue/characters/${character!.id}/talent-skill",
                                      ),
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const CircularProgressIndicator();
  }
}
