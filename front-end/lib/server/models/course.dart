import 'package:ecom_ass/server/models/review.dart';

class CourseModel {
  String id;
  String name;
  int duration;
  String category;
  double rating;
  int capacity;
  int enrolledStudents;
  List<ReviewModel> reviews;
  CourseModel(
    this.id,
    this.name,
    this.duration,
    this.category,
    this.rating,
    this.capacity,
    this.enrolledStudents, [
    this.reviews = const [],
  ]);

  factory CourseModel.fromJson(dynamic json) {
    if (json['reviews'] != null) {
      var reviewObjsJson = json['reviews'] as List;
      List<ReviewModel> reviews = reviewObjsJson
          .map((reviewJson) => ReviewModel.fromJson(reviewJson))
          .toList();

      return CourseModel(
          json['_id'] as String,
          json['name'] as String,
          json['duration'] as int,
          json['category'] as String,
          json['rating'] as double,
          json['capacity'] as int,
          json['enrolledStudents'] as int,
          reviews);
    } else {
      return CourseModel(
          json['_id'] as String,
          json['name'] as String,
          json['duration'] as int,
          json['category'] as String,
          json['rating'] as double,
          json['capacity'] as int,
          json['enrolledStudents'] as int);
    }
  }

  @override
  String toString() {
    return 'CourseModel(id: $id, name: $name, duration: $duration, category: $category, rating: $rating, capacity: $capacity, enrolledStudents: $enrolledStudents, reviews: $reviews)';
  }
}
