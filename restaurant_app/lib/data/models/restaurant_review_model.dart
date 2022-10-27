class RestaurantAddReview {
  RestaurantAddReview({
    required this.id,
    required this.name,
    required this.review,
  });

  String id;
  String name;
  String review;

  factory RestaurantAddReview.fromJson(Map<String, dynamic> json) =>
      RestaurantAddReview(
        id: json["id"],
        name: json["name"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}

class CustomerReview {
  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };
}
