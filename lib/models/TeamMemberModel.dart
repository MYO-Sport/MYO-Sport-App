class TeamMemberModel {
  late String memberId;
  late String memberName;
  late String memberEmail;
  late String memberImage;
  late String memberRole;
  late bool isTeamAdmin;
  late bool isTeamMod;

  TeamMemberModel(
      {
        required this.memberId,
        required this.memberName,
        required this.memberEmail,
        required this.memberImage,
        required this.memberRole,
        required this.isTeamAdmin,
        required this.isTeamMod});

  TeamMemberModel.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    memberName = json['member_name'];
    memberEmail = json['member_email'];
    memberImage = json['member_image']??'';
    memberRole = json['member_role']??'';
    isTeamAdmin = json['is_Team_Admin'];
    isTeamMod = json['is_Team_Mod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member_id'] = this.memberId;
    data['member_name'] = this.memberName;
    data['member_email'] = this.memberEmail;
    data['member_image'] = this.memberImage;
    data['member_role'] = this.memberRole;
    data['is_Team_Admin'] = this.isTeamAdmin;
    data['is_Team_Mod'] = this.isTeamMod;
    return data;
  }
}