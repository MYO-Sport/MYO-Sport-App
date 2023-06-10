class USRoleResponse {
  late bool status;
  late bool isAdmin;
  late String message;

  USRoleResponse({required this.status, required this.isAdmin,required this.message});

  USRoleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    isAdmin = json['is_admin']??false;
    message = json['message']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['is_admin'] = this.isAdmin;
    data['message'] = this.message;
    return data;
  }
}