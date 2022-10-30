import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_model.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({
    required this.apiService,
  }) {
    _fetchRestaurantWithQuery(query);
  }

  late RestaurantSearch _restaurantsSearch;
  late ResultState _state;
  String _message = '';
  String _query = '';

  String get message => _message;
  RestaurantSearch get result => _restaurantsSearch;
  String get query => _query;
  ResultState get state => _state;

  searchRestaurant(String newQuery) {
    _fetchRestaurantWithQuery(newQuery);
    notifyListeners();
  }

  Future<dynamic> _fetchRestaurantWithQuery(String query) async {
    try {
      _state = ResultState.loading;
      _query = query;
      final restaurant = await apiService.restaurantSearchList(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsSearch = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
