import 'dart:async';
import 'package:dio/dio.dart';

enum HttpMethod { GET, POST, PUT, DELETE }

class SimpleDioRequest {
  final String simpleUri;
  final HttpMethod simpleMethod;
  final Map<String, dynamic>? simpleBody;
  final Map<String, dynamic>? simpleQuery;
  final Map<String, dynamic>? simpleHeader;
  Response? _simpleResponse;

  SimpleDioRequest(
      {required this.simpleUri,
      required this.simpleMethod,
      this.simpleBody,
      this.simpleQuery,
      this.simpleHeader});

  // add simple header with value
  void addSimpleHeader(String key, dynamic value) {
    simpleHeader!.addAll({key: value});
  }

  // add simple headers with map of header
  void addSimpleHeaders(Map<String, dynamic> headers) {
    simpleHeader!.addAll(headers);
  }

  // get simple response data as List
  List<dynamic> getSimpleLists() {
    final data = _simpleResponse!.data;
    return data as List<dynamic>;
  }

  // get simple response data as Object
  Map<String, dynamic> getSimpleObject() {
    return _simpleResponse!.data;
  }

  // do simple request with dio
  Future<SimpleDioRequest> doSimpleDioRequest() async {
    final dioOption =
        BaseOptions(queryParameters: simpleQuery, headers: simpleHeader);
    final dio = Dio(dioOption);
    Response response;
    switch (simpleMethod) {
      case HttpMethod.GET:
        response = await dio.get(simpleUri);
        break;
      case HttpMethod.POST:
        response = await dio.post(simpleUri, data: simpleBody);
        break;
      case HttpMethod.PUT:
        response = await dio.put(simpleUri, data: simpleBody);
        break;
      case HttpMethod.DELETE:
        response = await dio.delete(simpleUri);
        break;
      default:
        throw "No method request";
    }

    _simpleResponse = response;

    return this;
  }
}
