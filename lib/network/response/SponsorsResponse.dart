import 'package:us_rowing/models/SponsorModel.dart';

class SponsorsResponse {
  late bool status;
  late String message;
  late List<SponsorModel> sponsers;

  SponsorsResponse({required this.status,required  this.message,required  this.sponsers});

  SponsorsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['sponsers'] != null) {
      sponsers = [];
      json['sponsers'].forEach((v) {
        sponsers.add(new SponsorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['sponsers'] = this.sponsers.map((v) => v.toJson()).toList();
    return data;
  }
}