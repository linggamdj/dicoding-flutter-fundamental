import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/commons/style.dart';
import 'package:restaurant_app/pages/detail_page.dart';
import 'package:restaurant_app/data/models/restaurant_model.dart';
import 'package:restaurant_app/provider/database_provider.dart';

class RestaurantList extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantList(this.restaurant, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(restaurant.id),
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
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(primaryColor),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: primaryColor,
                        ),
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
                              Expanded(
                                child: Text(
                                  restaurant.name,
                                  style: primaryTextStyle.copyWith(
                                    color: primaryColor,
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
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
                              Expanded(
                                child: Text(
                                  restaurant.city,
                                  style: subtitleTextStyle.copyWith(
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
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
                                Icons.star,
                                color: starColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  restaurant.rating.toString(),
                                  style: subtitleTextStyle.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    isFavorited
                        ? IconButton(
                            icon: const Icon(Icons.favorite),
                            color: primaryColor,
                            onPressed: () {
                              provider.removeFavorite(restaurant.id);
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.favorite_border),
                            color: primaryColor,
                            onPressed: () {
                              provider.addFavorite(restaurant);
                            },
                          ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
