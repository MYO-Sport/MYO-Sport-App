class TimeModel {
  late String value;
  late String amOrPm;

  TimeModel({required this.value, required this.amOrPm});

  TimeModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    amOrPm = json['amOrPm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['amOrPm'] = this.amOrPm;
    return data;
  }
}