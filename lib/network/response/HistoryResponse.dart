import 'package:us_rowing/models/HistoryModel.dart';

class HistoryResponse {
  late bool status;
  late String message;
  late List<HistoryModel> wrokoutDetails;

  HistoryResponse({required this.status, required this.message, required this.wrokoutDetails});

  HistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['wrokoutDetails'] != null) {
      wrokoutDetails = [];
      json['wrokoutDetails'].forEach((v) {
        wrokoutDetails.add(new HistoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['wrokoutDetails'] =
        this.wrokoutDetails.map((v) => v.toJson()).toList();
    return data;
  }
}