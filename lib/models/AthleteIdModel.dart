class AthleteIdModel {
  late String sId;
  late String athleteId;

  AthleteIdModel({required this.sId, required this.athleteId});

  AthleteIdModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    athleteId = json['athlete_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['athlete_id'] = this.athleteId;
    return data;
  }
}