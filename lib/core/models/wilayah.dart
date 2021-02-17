// To parse this JSON data, do
//
//     final wilayah = wilayahFromJson(jsonString);

import 'dart:convert';

Wilayah wilayahFromJson(String str) => Wilayah.fromJson(json.decode(str));

String wilayahToJson(Wilayah data) => json.encode(data.toJson());

class Wilayah {
  Wilayah({
    this.id,
    this.propinsi,
    this.kota,
    this.kecamatan,
    this.lat,
    this.lon,
  });

  String id;
  String propinsi;
  String kota;
  String kecamatan;
  String lat;
  String lon;

  factory Wilayah.fromJson(Map<String, dynamic> json) => Wilayah(
        id: json["id"],
        propinsi: json["propinsi"],
        kota: json["kota"],
        kecamatan: json["kecamatan"],
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "propinsi": propinsi,
        "kota": kota,
        "kecamatan": kecamatan,
        "lat": lat,
        "lon": lon,
      };
}
