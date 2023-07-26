// To parse this JSON data, do
//
//     final equipmentFeedbackResponse = equipmentFeedbackResponseFromJson(jsonString);

import 'dart:convert';

EquipmentFeedbackResponse equipmentFeedbackResponseFromJson(String str) => EquipmentFeedbackResponse.fromJson(json.decode(str));

String equipmentFeedbackResponseToJson(EquipmentFeedbackResponse data) => json.encode(data.toJson());

class EquipmentFeedbackResponse {
    bool status;
    String message;

    EquipmentFeedbackResponse({
        required this.status,
        required this.message,
    });

    factory EquipmentFeedbackResponse.fromJson(Map<String, dynamic> json) => EquipmentFeedbackResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
