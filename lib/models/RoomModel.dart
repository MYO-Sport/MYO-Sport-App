import 'package:us_rowing/models/MessageModel.dart';

class RoomModel {
  late String userId;
  late String userName;
  late String roomId;
  late String userProfile;
  late String userType;
  late MessageModel lastMessage;

  RoomModel({required this.userId, required this.userName, required this.roomId, required this.userProfile,required this.userType,required this.lastMessage});

  RoomModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name']??'';
    roomId = json['room_id'];
    userProfile = json['user_profile_image']??'';
    userType = json['user_type']??'';
    lastMessage = json['last_message'] != null ? new MessageModel.fromJson(json['last_message']):MessageModel(messageType: '', fileType: '', attachments: [], sId: '', senderId: '', body: '', senderName: '', senderEmail: '', senderImage: '', workoutId: '', updatedAt: '', createdAt: '',formattedLocalDate: '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['room_id'] = this.roomId;
    data['user_profile_image'] = this.userProfile;
    data['last_message'] = this.lastMessage;
    data['user_type'] = this.userType;
    return data;
  }
}