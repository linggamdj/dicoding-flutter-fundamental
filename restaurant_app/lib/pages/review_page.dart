import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/commons/style.dart';
import 'package:restaurant_app/provider/restaurant_review_provider.dart';

class ReviewPage extends StatelessWidget {
  final String id;
  const ReviewPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: '');
    TextEditingController reviewController = TextEditingController(text: '');

    RestaurantAddReviewProvider addReviewProvider =
        Provider.of<RestaurantAddReviewProvider>(context, listen: false);

    customHeader() {
      return AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add Your Review',
        ),
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(60),
              ],
              style: subtitleTextStyle,
              controller: nameController,
              decoration: InputDecoration(
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget reviewInput() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            TextFormField(
              style: subtitleTextStyle,
              controller: reviewController,
              decoration: InputDecoration(
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget addButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: TextButton(
          onPressed: () {
            if (nameController.text != '' && reviewController.text != '') {
              addReviewProvider.addReview(
                id,
                nameController.text,
                reviewController.text,
              );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: primaryColor,
                  content: const Text(
                    'Name and Review fields are required!',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Add Review',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: ListView(
          children: [
            nameInput(),
            reviewInput(),
            addButton(),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: customHeader(),
      body: content(),
    );
  }
}
