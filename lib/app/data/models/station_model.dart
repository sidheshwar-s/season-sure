// To parse this JSON data, do
//
//     final stationsModel = stationsModelFromJson(jsonString);

import 'dart:convert';

StationsModel? stationsModelFromJson(String str) => StationsModel.fromJson(json.decode(str));

String stationsModelToJson(StationsModel? data) => json.encode(data!.toJson());

class StationsModel {
    StationsModel({
        this.status,
        this.callCount,
        this.requestLat,
        this.requestLon,
        this.stationDistance,
        this.stations,
    });

    int? status;
    int? callCount;
    double? requestLat;
    double? requestLon;
    int? stationDistance;
    List<Station?>? stations;

    factory StationsModel.fromJson(Map<String, dynamic> json) => StationsModel(
        status: json["status"],
        callCount: json["callCount"],
        requestLat: json["requestLat"],
        requestLon: json["requestLon"],
        stationDistance: json["stationDistance"],
        stations: json["stations"] == null ? [] : json["stations"] == null ? [] : List<Station?>.from(json["stations"]!.map((x) => Station.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "callCount": callCount,
        "requestLat": requestLat,
        "requestLon": requestLon,
        "stationDistance": stationDistance,
        "stations": stations == null ? [] : stations == null ? [] : List<dynamic>.from(stations!.map((x) => x!.toJson())),
    };
}

class Station {
    Station({
        this.id,
        this.name,
        this.lat,
        this.lon,
        this.timezone,
    });

    String? id;
    String? name;
    String? lat;
    String? lon;
    String? timezone;

    factory Station.fromJson(Map<String, dynamic> json) => Station(
        id: json["id"],
        name: json["name"],
        lat: json["lat"],
        lon: json["lon"],
        timezone: json["timezone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
    };
}
