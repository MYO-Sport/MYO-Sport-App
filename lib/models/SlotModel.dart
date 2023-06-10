class SlotModel {
  late String sId;
  late String equipmentId;
  late String clubId;
  late String slotTime;
  late String status;
  late String date;
  late int availableQuantity;
  // late List<Null> reservations;
  late int iV;
  late String createdAt;
  late String updatedAt;

  SlotModel(
      { required this.sId,
        required this.equipmentId,
        required this.clubId,
        required this.slotTime,
        required this.status,
        required this.date,
        required this.availableQuantity,
        // required this.reservations,
        required this.iV,
        required this.createdAt,
        required this.updatedAt});

  SlotModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??'';
    equipmentId = json['equipment_id']??'';
    clubId = json['club_id']??'';
    slotTime = json['slot_time']??'';
    status = json['status']??'';
    date = json['date']??'';
    availableQuantity = json['available_quantity']??0;
    /*if (json['reservations'] != null) {
      reservations = new List<Null>();
      json['reservations'].forEach((v) {
        reservations.add(new Null.fromJson(v));
      });
    }*/
    iV = json['__v']??0;
    createdAt = json['createdAt']??'';
    updatedAt = json['updatedAt']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['equipment_id'] = this.equipmentId;
    data['club_id'] = this.clubId;
    data['slot_time'] = this.slotTime;
    data['status'] = this.status;
    data['date'] = this.date;
    data['available_quantity'] = this.availableQuantity;
    /*if (this.reservations != null) {
      data['reservations'] = this.reservations.map((v) => v.toJson()).toList();
    }*/
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}