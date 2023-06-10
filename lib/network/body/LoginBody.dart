class LoginBody {
  late String email;
  late String password;
  late int status;

  LoginBody({
    this.email='',
    this.password='',
    required this.status,
  });

  LoginBody.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['status'] = this.status;
    return data;
  }
}
