class GroupMessageModel {
  late String body;
  late String senderId;
  late String groupId;

  late String messageType;
  late String status;
  late List<String> attachments;
  late String workoutId;

  GroupMessageModel({ required this.body, required this.senderId, required this.groupId,required this.messageType, required this.status, required this.attachments, required this.workoutId});

  GroupMessageModel.fromJson(Map<String, dynamic> json) {
    body = json['message'];
    senderId = json['sender_id'];
    groupId = json['group_id'];

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
    data['group_id'] = this.groupId;
    data['status'] = this.status;
    data['message_type'] = this.messageType;
    data['workout_id'] = this.workoutId;
    data['attachments'] = this.attachments;
    return data;
  }
}