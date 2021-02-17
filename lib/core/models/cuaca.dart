// To parse this JSON data, do
//
//     final cuaca = cuacaFromJson(jsonString);

import 'dart:convert';

Cuaca cuacaFromJson(String str) => Cuaca.fromJson(json.decode(str));

String cuacaToJson(Cuaca data) => json.encode(data.toJson());

class Cuaca {
  Cuaca({
    this.jamCuaca,
    this.kodeCuaca,
    this.cuaca,
    this.humidity,
    this.tempC,
    this.tempF,
  });

  DateTime jamCuaca;
  String kodeCuaca;
  String cuaca;
  String humidity;
  String tempC;
  String tempF;

  factory Cuaca.fromJson(Map<String, dynamic> json) => Cuaca(
        jamCuaca: DateTime.parse(json["jamCuaca"]),
        kodeCuaca: json["kodeCuaca"],
        cuaca: json["cuaca"],
        humidity: json["humidity"],
        tempC: json["tempC"],
        tempF: json["tempF"],
      );

  Map<String, dynamic> toJson() => {
        "jamCuaca": jamCuaca.toIso8601String(),
        "kodeCuaca": kodeCuaca,
        "cuaca": cuaca,
        "humidity": humidity,
        "tempC": tempC,
        "tempF": tempF,
      };
}
