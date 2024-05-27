class NotificationModel {
  String id;
  String title;
  String message;
  String status;

  NotificationModel(this.id, this.title, this.message, this.status);

  factory NotificationModel.fromJson(dynamic json) {
    return NotificationModel(
      json['_id'] as String,
      json['title'] as String,
      json['message'] as String,
      json['status'] as String,
    );
  }
}
