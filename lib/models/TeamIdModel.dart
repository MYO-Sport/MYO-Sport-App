class TeamIdModel {
 late String sId;
 late String teamId;
 late bool isTeamMod;
 late bool isTeamAdmin;

  TeamIdModel({this.sId='', this.teamId='', this.isTeamMod=false, this.isTeamAdmin=false});

  TeamIdModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    teamId = json['team_id'];
    isTeamMod = json['is_Team_Mod']??false;
    isTeamAdmin = json['is_Team_Admin']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['team_id'] = this.teamId;
    data['is_Team_Mod'] = this.isTeamMod;
    data['is_Team_Admin'] = this.isTeamAdmin;
    return data;
  }
}