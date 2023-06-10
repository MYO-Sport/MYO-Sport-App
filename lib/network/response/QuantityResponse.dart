class QuantityResponse {
  late bool status;
  late String message;
  late int availableQuantity;

  QuantityResponse({required this.status, required this.message});

  QuantityResponse.fromJson(Map<String, dynamic> json) {
    status = json['status']??false;
    message = json['message']??"";
    availableQuantity = json['available_quantity']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['available_quantity'] = this.availableQuantity;
    return data;
  }
}