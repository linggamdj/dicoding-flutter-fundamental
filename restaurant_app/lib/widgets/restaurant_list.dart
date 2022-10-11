import 'package:restaurant_app/commons/style.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/pages/detail_page.dart';

class RestaurantList extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantList(this.restaurant, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(restaurant),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 15,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                restaurant.pictureId,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        restaurant.name,
                        style: primaryTextStyle.copyWith(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        restaurant.city,
                        style: subtitleTextStyle.copyWith(
                          fontSize: 16,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: starColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        restaurant.rating.toString(),
                        style: subtitleTextStyle.copyWith(
                          fontSize: 16,
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
    );
  }
}
