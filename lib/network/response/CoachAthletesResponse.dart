import 'package:us_rowing/models/PlayerModel.dart';

class CoachAtheltetesResponse {
  late bool status;
  late String message;
  late List<PlayerModel> players;

  CoachAtheltetesResponse({required this.status, required this.message, required this.players});

  CoachAtheltetesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['players'] != null) {
      players = [];
      json['players'].forEach((v) {
        players.add(new PlayerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['players'] = this.players.map((v) => v.toJson()).toList();
    return data;
  }
}