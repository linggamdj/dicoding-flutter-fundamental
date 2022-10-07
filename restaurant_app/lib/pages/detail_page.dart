import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/widgets/item_list.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget imageHeader() {
      return Column(
        children: [
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/images/restaurant.png",
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
                          "Restaurant 1",
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
                              "St. Penburg",
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
                              "4.6",
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
                    'Deskripsi',
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam faucibus, neque ut congue egestas, lacus tortor pulvinar erat, accumsan gravida est quam in mauris. Cras ac dui ullamcorper, facilisis tellus sit amet, dapibus mi. Mauris et vulputate libero. Curabitur ac nisi ut urna cursus bibendum nec non ante.",
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
                children: const [
                  ItemList(),
                  ItemList(),
                  ItemList(),
                  ItemList(),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget drinkList() {
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
          child: Row(
            children: const [
              ItemList(),
              ItemList(),
              ItemList(),
              ItemList(),
            ],
          ),
        ),
      );
    }

    return Material(
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
