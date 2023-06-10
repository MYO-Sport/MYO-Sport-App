class MessageBody {
  late String body;
  late String senderId;
  late String receiverId;
  late String roomId;

  late String messageType;
  late String status;
  late List<String> attachments;
  late String workoutId;

  MessageBody({ required this.body, required this.senderId, required this.receiverId, required this.roomId, required this.messageType, required this.status, required this.attachments, required this.workoutId});

  MessageBody.fromJson(Map<String, dynamic> json) {
    body = json['message'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    roomId = json['room_id'];

    status = json['status'];
    messageType = json['message_type'];
    workoutId = json['workout_id'];

    if (json['attachments'] != null) {
      attachments =  [];
      attachments = json['attachments'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.body;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['room_id'] = this.roomId;

    data['status'] = this.status;
    data['message_type'] = this.messageType;
    data['attachments'] = this.attachments;
    data['workout_id'] = this.workoutId;
    return data;
  }
}
