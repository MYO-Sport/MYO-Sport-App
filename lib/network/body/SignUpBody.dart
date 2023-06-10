class SignUpBody {
  late String username;
  late String email;
  late String contactNum;
  late String role;
  late String password;
  late String type;
  late String city;
  late String state;
  late String memberNumber;

  SignUpBody(
      {this.username='',
        this.email='',
        this.contactNum='',
        this.role='',
        this.password='',
        this.type='',
        this.city='',
        this.state='',
        this.memberNumber=''
      });

  SignUpBody.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    memberNumber = json['membership_number'];
    email = json['email'];
    contactNum = json['contact_num'];
    role = json['role'];
    password = json['password'];
    type = json['type'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['membership_number'] = this.memberNumber;
    data['email'] = this.email;
    data['contact_num'] = this.contactNum;
    data['role'] = this.role;
    data['password'] = this.password;
    data['type'] = this.type;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}