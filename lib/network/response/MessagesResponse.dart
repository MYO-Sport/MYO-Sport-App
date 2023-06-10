import 'package:us_rowing/models/MessageModel.dart';

class MessagesResponse {
  late bool status;
  late String message;
  late List<MessageModel> messages;

  MessagesResponse({required this.status,required this.message,required this.messages});

  MessagesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']??'';
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages.add(new MessageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['messages'] = this.messages.map((v) => v.toJson()).toList();
    return data;
  }
}