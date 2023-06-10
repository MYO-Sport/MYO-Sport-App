class SponsorModel {
  late String sId;
  late String name;
  late String description;
  late String address;
  late String image;
  late List<Products> products;
  late String createdAt;
  late String updatedAt;
  late int iV;

  SponsorModel(
      {required this.sId,
        required this.name,
        required this.description,
        required this.address,
        required this.image,
        required this.products,
        required this.createdAt,
        required this.updatedAt,
        required this.iV});

  SponsorModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    image = json['image'];
    if (json['products'] != null) {
      products =[];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['address'] = this.address;
    data['image'] = this.image;
    data['products'] = this.products.map((v) => v.toJson()).toList();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Products {
  late String sId;
  late String name;
  late String description;
  late String productImage;

  Products({required this.sId,required  this.name,required  this.description,required  this.productImage});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['product_image'] = this.productImage;
    return data;
  }
}