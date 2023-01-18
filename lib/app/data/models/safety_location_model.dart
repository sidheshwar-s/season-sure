import 'dart:convert';

SafetyLocationModel? safetyLocationModelFromJson(String str) =>
    SafetyLocationModel.fromJson(json.decode(str));

String safetyLocationModelToJson(SafetyLocationModel? data) =>
    json.encode(data!.toJson());

class SafetyLocationModel {
  SafetyLocationModel({
    this.data,
    this.meta,
  });

  List<Datum?>? data;
  Meta? meta;

  factory SafetyLocationModel.fromJson(Map<String, dynamic> json) =>
      SafetyLocationModel(
        data: json["data"] == null
            ? []
            : json["data"] == null
                ? []
                : List<Datum?>.from(
                    json["data"]!.map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : data == null
                ? []
                : List<dynamic>.from(data!.map((x) => x!.toJson())),
        "meta": meta,
      };
}

class Datum {
  Datum({
    this.id,
    this.self,
    this.name,
    this.geoCode,
    this.safetyScores,
  });

  String? id;
  Self? self;
  String? name;
  GeoCode? geoCode;
  SafetyScores? safetyScores;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        self: Self.fromJson(json["self"]),
        name: json["name"],
        geoCode: GeoCode.fromJson(json["geoCode"]),
        safetyScores: SafetyScores.fromJson(json["safetyScores"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "self": self,
        "name": name,
        "geoCode": geoCode,
        "safetyScores": safetyScores,
      };
}

class GeoCode {
  GeoCode({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory GeoCode.fromJson(Map<String, dynamic> json) => GeoCode(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class SafetyScores {
  SafetyScores({
    this.lgbtq,
    this.medical,
    this.overall,
    this.physicalHarm,
    this.politicalFreedom,
    this.theft,
    this.women,
  });

  int? lgbtq;
  int? medical;
  int? overall;
  int? physicalHarm;
  int? politicalFreedom;
  int? theft;
  int? women;

  factory SafetyScores.fromJson(Map<String, dynamic> json) => SafetyScores(
        lgbtq: json["lgbtq"],
        medical: json["medical"],
        overall: json["overall"],
        physicalHarm: json["physicalHarm"],
        politicalFreedom: json["politicalFreedom"],
        theft: json["theft"],
        women: json["women"],
      );

  Map<String, dynamic> toJson() => {
        "lgbtq": lgbtq,
        "medical": medical,
        "overall": overall,
        "physicalHarm": physicalHarm,
        "politicalFreedom": politicalFreedom,
        "theft": theft,
        "women": women,
      };
}

class Self {
  Self({
    this.type,
    this.methods,
  });

  String? type;
  List<Method?>? methods;

  factory Self.fromJson(Map<String, dynamic> json) => Self(
        type: json["type"],
        methods: json["methods"] == null
            ? []
            : json["methods"] == null
                ? []
                : List<Method?>.from(
                    json["methods"]!.map((x) => methodValues!.map[x])),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "methods": methods == null
            ? []
            : methods == null
                ? []
                : List<dynamic>.from(
                    methods!.map((x) => methodValues.reverse![x])),
      };
}

enum Method { GET }

final methodValues = EnumValues({"GET": Method.GET});

enum SubType { CITY, DISTRICT }

final subTypeValues =
    EnumValues({"CITY": SubType.CITY, "DISTRICT": SubType.DISTRICT});

enum Type { SAFETY_RATED_LOCATION }

final typeValues =
    EnumValues({"safety-rated-location": Type.SAFETY_RATED_LOCATION});

class Meta {
  Meta({
    this.count,
    this.links,
  });

  int? count;
  Links? links;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        count: json["count"],
        links: Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "links": links,
      };
}

class Links {
  Links({
    this.self,
    this.next,
    this.last,
    this.first,
  });

  String? self;
  String? next;
  String? last;
  String? first;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        next: json["next"],
        last: json["last"],
        first: json["first"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "next": next,
        "last": last,
        "first": first,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
