class GroupBody {
  late String name;
  late String createrId;
  late List<String> members;

  GroupBody({required this.name, required this.createrId, required this.members});

  GroupBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    createrId = json['creater_id'];
    members = json['members'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['creater_id'] = this.createrId;
    data['members'] = this.members;
    return data;
  }
}
