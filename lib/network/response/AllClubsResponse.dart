
import 'package:us_rowing/models/ClubModel.dart';

class AllClubsResponse {
  late bool status=true;
  late String message='Successful';
  late List<ClubModel> allClubs;

  AllClubsResponse({ required this.allClubs});

  AllClubsResponse.fromJson(Map<String, dynamic> json) {

    if (json['allClubs'] != null) {
      allClubs = [];
      json['allClubs'].forEach((v) {
        allClubs.add(new ClubModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allClubs'] = this.allClubs.map((v) => v.toJson()).toList();
    return data;
  }
}