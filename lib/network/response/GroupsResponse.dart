import 'package:us_rowing/models/GroupModel.dart';

class GroupsResponse {
  late bool status;
  late List<GroupModel> groups;

  GroupsResponse({required this.status, required this.groups});

  GroupsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['groups'] != null) {
      groups = [];
      json['groups'].forEach((v) {
        groups.add(new GroupModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['groups'] = this.groups.map((v) => v.toJson()).toList();
    return data;
  }
}