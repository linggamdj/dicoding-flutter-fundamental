import 'package:flutter/material.dart';
import 'package:restaurant_app/commons/style.dart';
import 'package:restaurant_app/data/models/restaurant_detail_model.dart';

class ItemList extends StatelessWidget {
  final String type;
  final Category item;

  const ItemList(this.type, this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(
        right: 15,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              type == 'food'
                  ? "assets/images/thumb_food.png"
                  : "assets/images/thumb_drink.png",
              width: 150,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(
              item.name,
              style: primaryTextStyle.copyWith(
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
