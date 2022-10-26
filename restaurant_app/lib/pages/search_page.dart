import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/commons/style.dart';
import 'package:restaurant_app/widgets/restaurant_list.dart';
import 'package:restaurant_app/widgets/error_message.dart';
import 'package:restaurant_app/data/models/restaurant_model.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(context),
      body: Consumer<RestaurantSearchProvider>(
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
                shrinkWrap: false,
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurants = state.result.restaurants[index];
                  return buildRestaurantItem(context, restaurants);
                },
              );

            case ResultState.noData:
              return const ErrorMessage('Restaurant Not Found  :(');

            default:
              if (state.message.substring(0, 6) == 'Failed') {
                return const ErrorMessage('There is no Internet connection');
              } else {
                return const ErrorMessage('Try to Search by Restaurant Name');
              }
          }
        },
      ),
    );
  }

  searchAppBar(context) {
    return AppBar(
      elevation: 2,
      backgroundColor: primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      title: Text(
        "Search Restaurant",
        style: TextStyle(color: whiteColor),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          padding: EdgeInsets.only(bottom: defaultMargin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Material(
              color: primaryColor,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(fontSize: 16, color: whiteColor),
                      decoration: InputDecoration.collapsed(
                        hintText: 'Search by Restaurant Name',
                        hintStyle: TextStyle(color: primaryTextColor),
                      ),
                      onChanged: (value) {
                        Provider.of<RestaurantSearchProvider>(context,
                                listen: false)
                            .searchRestaurant(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
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
