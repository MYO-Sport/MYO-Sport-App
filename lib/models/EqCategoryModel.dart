class EqCategoryModel {
  late String sId;
  late String categoryName;
  late String createrId;
  late String clubId;
  late String createdAt;
  late String updatedAt;
  late int iV;

  EqCategoryModel(
      {
        required this.sId,
        required this.categoryName,
        required this.createrId,
        required this.clubId,
        required this.createdAt,
        required this.updatedAt,
        required this.iV});

  EqCategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['category_name'];
    createrId = json['creater_id'];
    clubId = json['club_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category_name'] = this.categoryName;
    data['creater_id'] = this.createrId;
    data['club_id'] = this.clubId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}