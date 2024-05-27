class ReviewModel {
  String createdBy;
  String review;

  ReviewModel(this.createdBy, this.review);
  factory ReviewModel.fromJson(dynamic json) {
    return ReviewModel(json['createdBy'] as String, json['review'] as String);
  }
  @override
  String toString() => 'ReviewModel(createdBy: $createdBy, review: $review)';
}
