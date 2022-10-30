import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantAddReviewProvider extends ChangeNotifier {
  final ApiService apiService;
  String id;
  String name;
  String review;

  RestaurantAddReviewProvider({
    required this.apiService,
    this.id = '',
    this.name = '',
    this.review = '',
  });

  late ResultState _state;
  String _message = '';

  String get message => _message;
  ResultState get state => _state;

  addReview(String id, String name, String review) {
    _postAddReview(id, name, review);
    notifyListeners();
  }

  Future<dynamic> _postAddReview(String id, String name, String review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final reviewResult =
          await apiService.restaurantAddReview(id, name, review);
      if (reviewResult == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _message = 'Has Data';
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
