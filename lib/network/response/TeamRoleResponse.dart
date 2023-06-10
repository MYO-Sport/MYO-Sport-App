class TeamRoleResponse {
  late bool status;
  late String message;
  late bool isTeamAdmin;
  late bool isTeamMod;

  TeamRoleResponse({required this.status, required this.message, required this.isTeamAdmin, required this.isTeamMod});

  TeamRoleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    isTeamAdmin = json['is_Team_Admin'];
    isTeamMod = json['is_Team_Mod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['is_Team_Admin'] = this.isTeamAdmin;
    data['is_Team_Mod'] = this.isTeamMod;
    return data;
  }
}