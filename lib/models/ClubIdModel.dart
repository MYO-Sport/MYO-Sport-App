class ClubIdModel {
  late String sId;
  late String clubId;
  late bool isClubMod;
  late bool isClubAdmin;

  ClubIdModel({this.sId='', this.clubId='', this.isClubMod=false, this.isClubAdmin=false});

  ClubIdModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    clubId = json['club_id']??'';
    isClubMod = json['is_Club_Mod']??false;
    isClubAdmin = json['is_Club_Admin']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['club_id'] = this.clubId;
    data['is_Club_Mod'] = this.isClubMod;
    data['is_Club_Admin'] = this.isClubAdmin;
    return data;
  }
}