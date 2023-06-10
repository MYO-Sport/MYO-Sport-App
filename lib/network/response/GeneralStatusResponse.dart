class GeneralStatusResponse {
  late bool status;
  late String message;

  GeneralStatusResponse({required this.status, required this.message});

  GeneralStatusResponse.fromJson(Map<String, dynamic> json) {
    status = json['status']??false;
    message = json['message']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}