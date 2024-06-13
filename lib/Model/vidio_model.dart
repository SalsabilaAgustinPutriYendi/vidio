// To parse this JSON data, do
//
//     final modelVideo = modelVideoFromJson(jsonString);

import 'dart:convert';

ModelVidio modelVideoFromJson(String str) => ModelVidio.fromJson(json.decode(str));

String modelVideoToJson(ModelVidio data) => json.encode(data.toJson());

class ModelVidio {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelVidio({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelVidio.fromJson(Map<String, dynamic> json) => ModelVidio(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String judul;
  String deskripsi;
  String vidio;

  Datum({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.vidio,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    judul: json["judul"],
    deskripsi: json["deskripsi"],
    vidio: json["vidio"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "deskripsi": deskripsi,
    "vidio": vidio,
  };
}