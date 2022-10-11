import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/commons/style.dart';
import 'package:restaurant_app/widgets/item_list.dart';

class DetailPage extends StatelessWidget {
  final Restaurant restaurant;

  const DetailPage(this.restaurant, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget imageHeader() {
      return Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                child: Center(
                  child: Image.network(
                    restaurant.pictureId,
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColor,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      );
    }

    Widget mainContent() {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: whiteColor,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 20,
                              color: primaryColor,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              restaurant.city,
                              style: subtitleTextStyle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              size: 20,
                              color: starColor,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              restaurant.rating.toString(),
                              style: subtitleTextStyle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    restaurant.description,
                    style: subtitleTextStyle,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget itemTitle(String title) {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          bottom: 12,
        ),
        child: Text(
          title,
          style: primaryTextStyle.copyWith(
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget foodList() {
      String type = 'food';

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: whiteColor,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: defaultMargin,
          ),
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                children: restaurant.menus.foods
                    .map(
                      (food) => ItemList(type, food),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      );
    }

    Widget drinkList() {
      String type = 'drink';

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: whiteColor,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: defaultMargin,
            bottom: defaultMargin,
          ),
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                children: restaurant.menus.drinks
                    .map(
                      (item) => ItemList(type, item),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      );
    }

    return Material(
      color: whiteColor,
      child: ListView(
        children: [
          imageHeader(),
          mainContent(),
          itemTitle('Foods'),
          foodList(),
          itemTitle('Drinks'),
          drinkList(),
        ],
      ),
    );
  }
}
