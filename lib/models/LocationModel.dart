class LocationModel {
  LocationModel({
    required this.type,
    required this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    type: json["type"],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}
