class StatModel {
  late String total;
  late String average;

  StatModel({required this.total, required  this.average});

  StatModel.fromJson(Map<String, dynamic> json) {
    total = json['total']??'0';
    average = json['average']??'0';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['average'] = this.average;
    return data;
  }
}