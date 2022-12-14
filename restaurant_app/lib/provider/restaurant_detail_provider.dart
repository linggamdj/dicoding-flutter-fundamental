import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_detail_model.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    fetchRestaurantDetail(id);
  }

  late RestaurantDetailResult _restaurantDetailResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantDetailResult get result => _restaurantDetailResult;
  ResultState get state => _state;

  Future<dynamic> fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detail = await apiService.restaurantDetail(id, http.Client());
      if (detail.error == true) {
        _state = ResultState.noData;
        _message = 'Empty Data';
        notifyListeners();
        return _message;
      } else {
        _state = ResultState.hasData;
        _restaurantDetailResult = detail;
        notifyListeners();
        return _restaurantDetailResult;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
