import 'package:restaurant_app/widgets/restaurant_list.dart';
import 'package:restaurant_app/commons/style.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          final List<Restaurant> restaurants = parseRestaurants(snapshot.data);
          return restaurants.isNotEmpty
              ? ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    return buildRestaurantItem(context, restaurants[index]);
                  },
                )
              : Center(
                  child: Text(
                    'Terjadi Kesalahan pada Server',
                    style: primaryTextStyle.copyWith(
                        fontSize: 20, fontWeight: semiBold),
                  ),
                );
        },
      ),
    );
  }

  customAppBar() {
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
