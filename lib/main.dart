import 'package:flutter/material.dart';
import 'package:geokamus/screens/word_screen.dart';
import 'package:provider/provider.dart';

// screen or page
import 'screens/about_screen.dart';
import 'screens/favorite_screen.dart';
import 'screens/home_screen.dart';
import 'screens/result_screen.dart';
import 'screens/words_screen.dart';

// provider
import '../providers/abouts.dart';
import '../providers/words.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Words()),
        ChangeNotifierProvider(create: (context) => Abouts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GEOKAMUS',
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          WordsScreen.routeName: (context) => const WordsScreen(),
          FavoriteScreen.routeName: (context) => const FavoriteScreen(),
          ResultScreen.routeName: (context) => const ResultScreen(),
          AboutScreen.routeName: (context) => const AboutScreen(),
          WordScreen.routeName: (context) => const WordScreen(),
        },
      ),
    );
  }
}
