class GeneralResponse {
  late bool success;
  late String message;

  GeneralResponse({required this.success, required this.message});

  GeneralResponse.fromJson(Map<String, dynamic> json) {
    success = json['success']??false;
    message = json['message']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}