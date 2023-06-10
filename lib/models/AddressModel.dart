class AddressModel {
  late String city;
  late String state;

  AddressModel({this.city='', this.state=''});

  AddressModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}
