import 'package:flutter/material.dart';
import 'package:genshin_impact/providers/character.dart';
import 'package:genshin_impact/screens/character_screen.dart';
import 'package:genshin_impact/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CharacterProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Genshim Impact Characters',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFD1A88A),
            primary: const Color(0xFFD1A88A),
          ),
        ),
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => const SearchScreen(),
          '/character': (BuildContext context) => const CharacterScreen(),
        },
        initialRoute: '/');
  }
}
