import 'package:ecom_ass/server/models/review.dart';

class AdminCourseModel {
  String id;
  String name;
  int duration;
  String category;
  double rating;
  int capacity;
  String createdBy;
  int rateNo;
  bool published;
  int requestedStudents;
  int enrolledStudents;
  int pastStudents;
  List<ReviewModel> reviews;
  AdminCourseModel(
    this.id,
    this.name,
    this.duration,
    this.category,
    this.rating,
    this.capacity,
    this.createdBy,
    this.rateNo,
    this.published,
    this.requestedStudents,
    this.enrolledStudents,
    this.pastStudents, [
    this.reviews = const [],
  ]);

  factory AdminCourseModel.fromJson(dynamic json) {
    if (json['reviews'] != null) {
      var reviewObjsJson = json['reviews'] as List;
      List<ReviewModel> reviews = reviewObjsJson
          .map((reviewJson) => ReviewModel.fromJson(reviewJson))
          .toList();

      return AdminCourseModel(
          json['_id'] as String,
          json['name'] as String,
          json['duration'] as int,
          json['category'] as String,
          json['rating'] as double,
          json['capacity'] as int,
          json['createdBy'] as String,
          json['rateNo'] as int,
          json['published'] as bool,
          json['requestedStudents'] as int,
          json['enrolledStudents'] as int,
          json['pastStudents'] as int,
          reviews);
    } else {
      return AdminCourseModel(
        json['_id'] as String,
        json['name'] as String,
        json['duration'] as int,
        json['category'] as String,
        json['rating'] as double,
        json['capacity'] as int,
        json['createdBy'] as String,
        json['rateNo'] as int,
        json['published'] as bool,
        json['requestedStudents'] as int,
        json['enrolledStudents'] as int,
        json['pastStudents'] as int,
      );
    }
  }

  @override
  String toString() {
    return 'CourseModel(id: $id, name: $name, duration: $duration, category: $category, rating: $rating, capacity: $capacity, enrolledStudents: $enrolledStudents, reviews: $reviews)';
  }
}
