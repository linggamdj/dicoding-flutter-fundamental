import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/pages/search_page.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'pages/splash_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantSearchProvider(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/search': (content) => const SearchPage(),
        },
      ),
    );
  }
}
