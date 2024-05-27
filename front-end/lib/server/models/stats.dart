import 'package:ecom_ass/server/models/course_stat.dart';
import 'package:ecom_ass/server/models/top.dart';

class StatsModel {
  TopModel enrolled;
  TopModel rated;
  TopModel reviewed;
  List<CourseStatModel> courses;

  StatsModel(this.enrolled, this.rated, this.reviewed,
      [this.courses = const []]);
  StatsModel.withDefaults()
      : enrolled = TopModel('', 0),
        rated = TopModel('', 0),
        reviewed = TopModel('', 0),
        courses = <CourseStatModel>[];

  factory StatsModel.fromJson(dynamic json) {
    var coursesbjsJson = json['courses'] as List;
    List<CourseStatModel> courses = coursesbjsJson
        .map((reviewJson) => CourseStatModel.fromJson(reviewJson))
        .toList();
    return StatsModel(
      TopModel.fromJson(json['topEnrolled']),
      TopModel.fromJson(json['topRated']),
      TopModel.fromJson(json['topReviewed']),
      courses,
    );
  }
}
