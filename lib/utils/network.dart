import 'package:http/http.dart' as http;
import 'package:cook_mother/utils/api.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';

const Duration duration = const Duration(milliseconds: 3000);

/**
 * http get
 */
Future<Map> getHttp({host, path, query}) async {
  Map res;
  HttpClient httpClient = new HttpClient();
  Uri uri = new Uri.http(host, path, query);
  print(host + path);
  HttpClientRequest request = await httpClient.getUrl(uri).timeout(duration);
  HttpClientResponse response = await request.close();
  if (response.statusCode != HttpStatus.OK) {
    throw new Exception(response.statusCode);
  }
  String responseBody = await response.transform(utf8.decoder).join();
  print(responseBody);
  res = json.decode(responseBody);
  return res;
}
/**
 * https get
 */
Future<Map> getHttps({host, path, query}) async {
  Map res;
  HttpClient httpClient = new HttpClient();
  Uri uri = new Uri.https(host, path, query);
  print(host + path);
  HttpClientRequest request = await httpClient.getUrl(uri).timeout(duration);
  HttpClientResponse response = await request.close();
  if (response.statusCode != HttpStatus.OK) {
    throw new Exception(response.statusCode);
  }
  String responseBody = await response.transform(utf8.decoder).join();
  res = json.decode(responseBody);
  return res;
}
/**
 * http post
 */
Future<Map> postHttp({host, path, query}) async {
  Map res;
  HttpClient httpClient = new HttpClient();
  Uri uri = new Uri.http(host, path, query);
  print(host + path);
  HttpClientRequest request = await httpClient.postUrl(uri).timeout(duration);
  HttpClientResponse response = await request.close();
  if (response.statusCode != HttpStatus.OK) {
    throw new Exception(response.statusCode);
  }
  String responseBody = await response.transform(utf8.decoder).join();
  res = json.decode(responseBody);
  return res;
}
/**
 * https post
 */
Future<Map> postHttps({host, path, query}) async {
  Map res;
  HttpClient httpClient = new HttpClient();
  Uri uri = new Uri.https(host, path, query);
  print(host + path);
  HttpClientRequest request = await httpClient.postUrl(uri).timeout(duration);
  HttpClientResponse response = await request.close();
  if (response.statusCode != HttpStatus.OK) {
    throw new Exception(response.statusCode);
  }
  String responseBody = await response.transform(utf8.decoder).join();
  res = json.decode(responseBody);
  return res;
}