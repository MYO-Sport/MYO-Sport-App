class ClubMessageBody {
  late String body;
  late String senderId;
  late String clubId;

  late String messageType;
  late String status;
  late List<String> attachments;

  ClubMessageBody({ required this.body, required this.senderId, required this.clubId,required this.messageType, required this.status, required this.attachments});

  ClubMessageBody.fromJson(Map<String, dynamic> json) {
    body = json['message'];
    senderId = json['sender_id'];
    clubId = json['club_id'];

    status = json['status'];
    messageType = json['message_type'];

    if (json['attachments'] != null) {
      attachments =  [];
      attachments = json['attachments'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.body;
    data['sender_id'] = this.senderId;
    data['club_id'] = this.clubId;

    data['status'] = this.status;
    data['message_type'] = this.messageType;
    data['attachments'] = this.attachments;
    return data;
  }
}