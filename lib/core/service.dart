import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:test_reka/core/models/cuaca.dart';
import 'package:test_reka/core/models/wilayah.dart';
import 'api.dart';

Future<dynamic> getHttp(String url) async {
  try {
    Response response = await Dio().get(url);
    var r = response;
    return r;
  } catch (e) {
    return null;
  }
}

Future<List<Wilayah>> getWilayah() async {
  var data = await getHttp(API.getWilayah);
  print(data);
  var d = data.data as List;
  List<Wilayah> load = [];
  d.forEach((e) {
    load.add(Wilayah.fromJson(e));
  });
  return load;
}

Future<List<Cuaca>> getCuaca(String idWilayah) async {
  var data = await getHttp(API.baseURL + '$idWilayah.json');
  print(data);
  var d = data.data as List;
  List<Cuaca> load = [];
  d.forEach((e) {
    load.add(Cuaca.fromJson(e));
  });
  return load;
}
