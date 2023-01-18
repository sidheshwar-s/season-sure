import 'dart:convert';

AqiModel? aqiModelFromJson(String str) => AqiModel.fromJson(json.decode(str));

String aqiModelToJson(AqiModel? data) => json.encode(data!.toJson());

class AqiModel {
  AqiModel({
    this.coord,
    this.list,
  });

  List<int?>? coord;
  List<ListElement?>? list;

  factory AqiModel.fromJson(Map<String, dynamic> json) => AqiModel(
        list: json["list"] == null
            ? []
            : json["list"] == null
                ? []
                : List<ListElement?>.from(
                    json["list"]!.map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "coord": coord == null
            ? []
            : coord == null
                ? []
                : List<dynamic>.from(coord!.map((x) => x)),
        "list": list == null
            ? []
            : list == null
                ? []
                : List<dynamic>.from(list!.map((x) => x!.toJson())),
      };
}

class ListElement {
  ListElement({
    this.dt,
    this.main,
    this.components,
  });

  int? dt;
  Main? main;
  Map<String, dynamic>? components;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        main: Main.fromJson(json["main"]),
        components: json["components"],
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main,
        "components": components,
      };
}

class Main {
  Main({
    this.aqi,
  });

  int? aqi;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        aqi: json["aqi"],
      );

  Map<String, dynamic> toJson() => {
        "aqi": aqi,
      };
}
