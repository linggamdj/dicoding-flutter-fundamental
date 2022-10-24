import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_model.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  final String query;

  RestaurantSearchProvider({
    required this.apiService,
    this.query = '',
  }) {
    _fetchRestaurantWithQuery(query);
  }

  late RestaurantResult _restaurantsResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantResult get result => _restaurantsResult;

  ResultState get state => _state;

  searchRestaurant(String query) {
    _fetchRestaurantWithQuery(query);
    notifyListeners();
  }

  Future<dynamic> _fetchRestaurantWithQuery(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantSearchList(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
