import 'package:ecom_ass/server/models/student.dart';

class RequestModel {
  String id;
  String name;
  List<StudentModel> students;
  RequestModel(this.id, this.name, this.students);

  factory RequestModel.fromJson(dynamic json) {
    var studentsList = json['requestedStudents'] as List;
    List<StudentModel> students = studentsList
        .map((studentJson) => StudentModel.fromJson(studentJson))
        .toList();
    return RequestModel(
        json['_id'] as String, json['name'] as String, students);
  }

  @override
  String toString() =>
      'RequestModel(id: $id, name: $name, students: $students)';
}
