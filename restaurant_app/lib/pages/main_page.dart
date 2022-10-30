import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/commons/style.dart';
import 'package:restaurant_app/widgets/restaurant_list.dart';
import 'package:restaurant_app/widgets/error_message.dart';
import 'package:restaurant_app/data/models/restaurant_model.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          switch (state.state) {
            case ResultState.loading:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              );

            case ResultState.hasData:
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = state.result.restaurants[index];
                  return buildRestaurantItem(context, restaurant);
                },
              );

            case ResultState.noData:
              return const ErrorMessage(
                  'Data Not Found. Internal Server Error');

            case ResultState.error:
              return const ErrorMessage('There is no Internet connection');
          }
        },
      ),
    );
  }

  customAppBar(context) {
    return AppBar(
      elevation: 2,
      titleSpacing: 0,
      toolbarHeight: 145,
      backgroundColor: primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      title: Container(
        padding: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: defaultMargin,
                  ),
                  Text(
                    'Restaurant',
                    style: whiteTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    'Recommendation restaurant near you!',
                    style: informationTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.search_outlined,
                size: 35,
              ),
              color: whiteColor,
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget restaurants(Restaurant restaurant) {
    return Column(
      children: [
        RestaurantList(restaurant),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: [
        restaurants(restaurant),
      ],
    );
  }
}
