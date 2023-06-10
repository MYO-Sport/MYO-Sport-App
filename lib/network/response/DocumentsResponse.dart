import 'package:us_rowing/models/DocumentModel.dart';

class DocumentsResponse {
  late bool status;
  late String message;
  late List<DocumentModel> libraries;

  DocumentsResponse({required this.status,required this.message,required this.libraries});

  DocumentsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['libraries'] != null) {
      libraries = [];
      json['libraries'].forEach((v) {
        libraries.add(new DocumentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['libraries'] = this.libraries.map((v) => v.toJson()).toList();
    return data;
  }
}