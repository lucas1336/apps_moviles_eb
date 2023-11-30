import 'package:flutter/material.dart';
import 'package:flutter_app/screens/favorites_screen.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/list_screen.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'list',
          builder: (context, state) => const ListScreen(),
        ),
        GoRoute(
          path: 'favorites',
          builder: (context, state) => const FavoriteScreen(),
        )
      ])
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Superhero App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.green,
        ),
      ),
      routerConfig: _router,
    );
  }
}
