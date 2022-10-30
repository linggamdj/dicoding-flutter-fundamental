import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_detail_model.dart';
import 'package:restaurant_app/data/models/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';

void main() {
  group(
    'Test restaurant API',
    () {
      test(
        'Should return restaurant list',
        () async {
          final mockClient = MockClient(
            (request) async {
              final response = {
                "error": false,
                "message": "failed",
                "count": 0,
                "restaurants": [],
              };
              return http.Response(json.encode(response), 200);
            },
          );
          expect(
            await ApiService().restaurantList(mockClient),
            isA<RestaurantResult>(),
          );
        },
      );

      test(
        'Should return restaurant detail',
        () async {
          final mockClient = MockClient(
            (request) async {
              final response = {
                "error": false,
                "message": "success",
                "restaurant": {
                  "id": "",
                  "name": "",
                  "description": "",
                  "city": "",
                  "address": "",
                  "pictureId": "",
                  "categories": [],
                  "menus": {
                    "foods": [],
                    "drinks": [],
                  },
                  "rating": 0.0,
                  "customerReviews": []
                }
              };
              return http.Response(json.encode(response), 200);
            },
          );

          expect(
            await ApiService().restaurantDetail('r-123', mockClient),
            isA<RestaurantDetailResult>(),
          );
        },
      );
    },
  );
}
