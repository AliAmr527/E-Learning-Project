class MyCourseModel {
  String id;
  String name;
  int duration;
  String category;
  double rating;
  String status;

  MyCourseModel(
    this.id,
    this.name,
    this.duration,
    this.category,
    this.rating,
    this.status,
  );

  factory MyCourseModel.fromJson(dynamic json) {
    return MyCourseModel(
      json['_id'] as String,
      json['name'] as String,
      json['duration'] as int,
      json['category'] as String,
      json['rating'] as double,
      json['status'] as String,
    );
  }

  @override
  String toString() {
    return 'MyCourseModel(name: $name, id: $id, duration: $duration, category: $category, rating: $rating, status: $status)';
  }
}
