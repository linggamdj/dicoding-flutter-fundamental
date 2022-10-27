import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/models/restaurant_model.dart';
import 'package:restaurant_app/data/models/restaurant_detail_model.dart';
import 'package:restaurant_app/data/models/restaurant_review_model.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> restaurantList() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));

    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantSearch> restaurantSearchList(String query) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResult> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }

  Future<RestaurantAddReview> restaurantAddReview(
      String id, String name, String review) async {
    final response = await http.post(
      Uri.parse("${_baseUrl}review"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'id': id,
          'name': name,
          'review': review,
        },
      ),
    );

    if (response.statusCode == 200) {
      return RestaurantAddReview.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }
}
