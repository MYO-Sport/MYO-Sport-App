class ChatBody {
  late String senderId;
  late String receiverId;

  ChatBody({ required this.senderId, required this.receiverId,});

  ChatBody.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    return data;
  }
}
