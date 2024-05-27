class StudentModel {
  String name;
  String id;

  StudentModel(
    this.name,
    this.id,
  );

  factory StudentModel.fromJson(dynamic json) {
    return StudentModel(
      json['name'] as String,
      json['_id'] as String,
    );
  }

  @override
  String toString() => 'StudentModel(name: $name, id: $id)';
}
