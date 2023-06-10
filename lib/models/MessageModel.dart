import 'package:intl/intl.dart';

class MessageModel {
  late String messageType;
  late String fileType;
  late List<String> attachments;
  late String sId;
  late String senderId;
  late String body;
  late String senderName;
  late String senderEmail;
  late String senderImage;
  late String workoutId;
  late String createdAt;
  late String updatedAt;
  late String formattedLocalDate;

  MessageModel(
      {
        required this.messageType,
        required this.fileType,
        required this.attachments,
        required this.sId,
        required this.senderId,
        required this.body,
        required this.senderName,
        required this.senderEmail,
        required this.senderImage,
        required this.workoutId,
        required this.updatedAt,
        required this.createdAt,
        required this.formattedLocalDate
      });

  MessageModel.fromJson(Map<String, dynamic> json) {
    messageType = json['message_type'];
    fileType = json['file_type']??'';
    if (json['attachments'] != null) {
      attachments =  [];
      attachments = json['attachments'].cast<String>();
    }
    sId = json['_id']??'';
    senderId = json['sender_id']??'';
    body = json['body']??'';
    senderName = json['sender_name']??'';
    senderEmail = json['sender_email']??'';
    senderImage = json['sender_image']??'';
    workoutId = json['workout_id']??'';
    createdAt = json['created_at']??'';
    if(json['created_at']==null || json['created_at']==''){
      formattedLocalDate='';
    }else{
      DateTime dt = DateTime.parse(json['created_at']).toLocal();
      var formatter = new DateFormat('dd MMMM yyyy');
      formattedLocalDate=formatter.format(dt);
    }
    updatedAt = json['updated_at']??'';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message_type'] = this.messageType;
    data['file_type'] = this.fileType;
    data['attachments'] = this.attachments;
    data['_id'] = this.sId;
    data['sender_id'] = this.senderId;
    data['body'] = this.body;
    data['sender_name'] = this.senderName;
    data['sender_email'] = this.senderEmail;
    data['sender_image'] = this.senderImage;
    data['workout_id'] = this.workoutId;
    data['created_at'] = this.workoutId;
    data['updated_at'] = this.workoutId;
    return data;
  }
}