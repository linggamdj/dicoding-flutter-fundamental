import 'package:restaurant_app/commons/style.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_detail_model.dart';

class ReviewList extends StatelessWidget {
  final CustomerReview review;

  const ReviewList(this.review, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      margin: EdgeInsets.only(
        right: 15,
        bottom: defaultMargin,
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
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            child: Text(
              '"${review.review}"',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Text(
              review.name,
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            review.date,
            style: primaryTextStyle.copyWith(
              fontSize: 12,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
