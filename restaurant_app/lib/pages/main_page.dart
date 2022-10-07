import 'package:restaurant_app/widgets/restaurant_list.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget customHeader() {
      return Container(
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
      );
    }

    Widget restaurants() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          children: const [
            RestaurantList(),
            RestaurantList(),
            RestaurantList(),
            RestaurantList(),
            RestaurantList(),
          ],
        ),
      );
    }

    return Material(
      child: ListView(
        children: [
          customHeader(),
          restaurants(),
        ],
      ),
    );
  }
}
