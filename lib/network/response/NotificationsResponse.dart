import 'package:us_rowing/models/NotificationModel.dart';

class NotificationsResponse {
  late bool status;
  late String message;
  late List<NotificationModel> notifications;

  NotificationsResponse({required this.status,required this.message,required this.notifications});

  NotificationsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['notifications'] != null) {
      notifications = [];
      json['notifications'].forEach((v) {
        notifications.add(new NotificationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['notifications'] =
        this.notifications.map((v) => v.toJson()).toList();
    return data;
  }
}