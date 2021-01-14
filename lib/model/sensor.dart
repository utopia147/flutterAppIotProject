// To parse this JSON data, do
//
//     final sensorModel = sensorModelFromJson(jsonString);

import 'dart:convert';

SensorModel sensorModelFromJson(String str) =>
    SensorModel.fromJson(json.decode(str));

String sensorModelToJson(SensorModel data) => json.encode(data.toJson());

class SensorModel {
  SensorModel({
    this.nodemcuid,
    this.sensorname,
    this.sensorval,
  });

  String nodemcuid;
  String sensorname;
  List<int> sensorval;

  factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
        nodemcuid: json["nodemcuid"],
        sensorname: json["sensorname"],
        sensorval: List<int>.from(json["sensorval"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "nodemcuid": nodemcuid,
        "sensorname": sensorname,
        "sensorval": List<dynamic>.from(sensorval.map((x) => x)),
      };
}
