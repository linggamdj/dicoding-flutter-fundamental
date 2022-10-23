import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_detail_model.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/commons/style.dart';
import 'package:restaurant_app/widgets/error_message.dart';
import 'package:restaurant_app/widgets/item_list.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/widgets/review_list.dart';

class DetailPage extends StatelessWidget {
  final String id;

  const DetailPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (context) =>
          RestaurantDetailProvider(apiService: ApiService(), id: id),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              shrinkWrap: false,
              itemCount: 1,
              itemBuilder: (context, index) {
                var detail = state.result.restaurant;
                return buildRestaurantDetailItem(context, detail);
              },
            );
          } else {
            return const ErrorMessage('Internal Server Error');
          }
        },
      ),
    );
  }

  Widget imageHeader(context, String id) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              child: Center(
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/large/$id',
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

  Widget mainContent(
      String name, String city, double rating, String description) {
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
                        name,
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
                            city,
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
                            rating.toString(),
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
                  description,
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

  Widget foodList(Restaurant detail) {
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
              children: detail.menus.foods
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

  Widget drinkList(Restaurant detail) {
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
        ),
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: detail.menus.drinks
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

  Widget reviewList(Restaurant detail) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: defaultMargin,
      ),
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Row(
            children: detail.customerReviews
                .map(
                  (item) => ReviewList(item),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget buildRestaurantDetailItem(BuildContext context, Restaurant detail) {
    return Material(
      color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageHeader(context, detail.pictureId),
          mainContent(
              detail.name, detail.city, detail.rating, detail.description),
          itemTitle('Foods'),
          foodList(detail),
          itemTitle('Drinks'),
          drinkList(detail),
          itemTitle('Customer Reviews'),
          reviewList(detail),
        ],
      ),
    );
  }
}
