// To parse this JSON data, do
//
//     final logsData = logsDataFromJson(jsonString);

import 'dart:convert';

List<LogsData> logsDataFromJson(String str) => List<LogsData>.from(json.decode(str).map((x) => LogsData.fromJson(x)));

String logsDataToJson(List<LogsData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LogsData {
    LogsData({
        this.id,
        this.avgValue1,
        this.avgValue2,
    });

    Id id;
    int avgValue1;
    double avgValue2;

    factory LogsData.fromJson(Map<String, dynamic> json) => LogsData(
        id: Id.fromJson(json["_id"]),
        avgValue1: json["avgValue1"],
        avgValue2: json["avgValue2"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "avgValue1": avgValue1,
        "avgValue2": avgValue2,
    };
}

class Id {
    Id({
        this.sensor,
        this.year,
        this.month,
        this.day,
    });

    String sensor;
    int year;
    int month;
    int day;

    factory Id.fromJson(Map<String, dynamic> json) => Id(
        sensor: json["sensor"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
    );

    Map<String, dynamic> toJson() => {
        "sensor": sensor,
        "year": year,
        "month": month,
        "day": day,
    };
}
