// To parse this JSON data, do
//
//     final logsData = logsDataFromJson(jsonString);

import 'dart:convert';

List<LogsData> logsDataFromJson(String str) =>
    List<LogsData>.from(json.decode(str).map((x) => LogsData.fromJson(x)));

String logsDataToJson(List<LogsData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LogsData {
  LogsData({
    this.data,
    this.createdAt,
    this.id,
    this.logid,
    this.category,
    this.v,
  });

  List<int> data;
  DateTime createdAt;
  String id;
  String logid;
  String category;
  int v;

  factory LogsData.fromJson(Map<String, dynamic> json) => LogsData(
        data: List<int>.from(json["data"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAT"]),
        id: json["_id"],
        logid: json["logid"],
        category: json["category"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x)),
        "createdAT": createdAt.toIso8601String(),
        "_id": id,
        "logid": logid,
        "category": category,
        "__v": v,
      };
}
