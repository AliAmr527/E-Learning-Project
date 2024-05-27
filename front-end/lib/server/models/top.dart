class TopModel {
  String name;
  double score;
  TopModel( this.name,  this.score);
  factory TopModel.fromJson(dynamic json) {
    return TopModel(
      json['name'] as String,
      json['score'] as double,
    );
  }
}
