class ClubRoleResponse {
  late bool status;
  late String message;
  late bool isClubAdmin;
  late bool isClubMod;

  ClubRoleResponse({required this.status, required this.message, required this.isClubAdmin, required this.isClubMod});

  ClubRoleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    isClubAdmin = json['is_Club_Admin'];
    isClubMod = json['is_Club_Mod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['is_Club_Admin'] = this.isClubAdmin;
    data['is_Club_Mod'] = this.isClubMod;
    return data;
  }
}