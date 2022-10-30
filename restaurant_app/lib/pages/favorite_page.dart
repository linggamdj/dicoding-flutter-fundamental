import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/commons/style.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/error_message.dart';
import 'package:restaurant_app/widgets/restaurant_list.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  Widget buildFavoriteList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        switch (provider.state) {
          case ResultState.loading:
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            );

          case ResultState.hasData:
            return ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                return RestaurantList(provider.favorites[index]);
              },
            );

          case ResultState.noData:
            return const ErrorMessage('Your Favorite Restaurant is Empty :(');

          case ResultState.error:
            return const ErrorMessage('There is no Internet connection');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Favorites',
        ),
      ),
      body: buildFavoriteList(),
    );
  }
}
