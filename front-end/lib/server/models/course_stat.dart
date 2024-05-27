class CourseStatModel {
  String name;
  double rating;
  int enrolledStudents;
  int reviews;
  CourseStatModel(this.name, this.rating, this.enrolledStudents, this.reviews);
  factory CourseStatModel.fromJson(dynamic json) {
    return CourseStatModel(
        json['name'] as String,
        json['rating'] as double,
        json['enrolledStudents'] as int,
        json['reviews'] as int);
  }
}
