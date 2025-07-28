import 'dart:convert';
import 'dart:io';

import 'package:servi_drive/core/resource/constant_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../storage/shared/shared_pref.dart';
import 'api_url.dart';

class ApiMethods {
  late Map<String, String> headers;
  final bool? isSecondBaseUrl;

  ApiMethods({Map<String, String>? header, this.isSecondBaseUrl}) {
    if (header == null) {
      headers = {
        "X-Parse-Application-Id": "chamsale",
        "X-Parse-REST-API-Key": "D5g3A3eVTQV8vzzlXk2qGEHh41a",
      };
      if (AppSharedPreferences.getToken().isNotEmpty) {
        final token = AppSharedPreferences.getToken();
        if (token.isNotEmpty) {
          headers['X-Parse-Session-Token'] = token;
        } else {}
      } else {}
    } else {
      headers = header;
    }
  }

  Map<String, dynamic> filterRequest(Map<String, dynamic> inputMap) {
    final filteredMap = inputMap
      ..removeWhere((key, value) =>
          value == null ||
          value == DateTime(0) ||
          value == '' ||
          value == -1 ||
          value == {} ||
          value == '{}' ||
          value is Map && value.isEmpty ||
          value == "0000-01-01" ||
          value == [] ||
          value == "0000-01-0");
    filteredMap.forEach(
      (key, value) {
        if (value is Map<String, dynamic>) {
          filterRequest(value);
          filteredMap[key] = filterRequest(value);
        }
      },
    );
    return filteredMap;
  }


  Future<http.Response> get(
      {required String url,
      Map<String, dynamic>? path,
      Map<String, dynamic>? query}) async {
    late Map<String, String> newHeaders;
    newHeaders = headers;
    newHeaders.remove("Content-type");
    if (query != null) {
      query = filterRequest(query);
    }
    if (path != null) {
      path = filterRequest(path);
    }

    Uri link;
    http.Response response;
    if (path != null && query != null && query.isNotEmpty && path.isNotEmpty) {
      link = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getPath(path)
          .getQuery(query)
          .getLink();
    } else if (query != null && query.isNotEmpty) {
      link = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getQuery(query)
          .getLink();
    } else if (path != null && path.isNotEmpty) {
      link = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getPath(path)
          .getLink();
    } else {
      link = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl).getLink();
    }


    response = await http.get(link, headers: newHeaders);


    return response;
  }

  Future<http.Response> post(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query}) async {
    if (query != null) {
      query = filterRequest(query);
    }
    if (body != null) {
      body = filterRequest(body);
    }
    Uri link;
    http.Response response;
    if (body != null && query != null && query.isNotEmpty) {
      link = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getQuery(query)
          .getLink();
      response =
          await http.post(link, body: jsonEncode(body), headers: headers);
    } else if (query != null && query.isNotEmpty) {
      link = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getQuery(query)
          .getLink();
      response = await http.post(link, headers: headers);
    } else {
      link = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl).getLink();
      response =
          await http.post(link, body: jsonEncode(body), headers: headers);
    }

    if (body != null) {
    }

    return response;
  }


  Future<http.Response> put(
      {required String url, body, required Map<String, dynamic> query}) async {
    query = filterRequest(query);
    Uri link;
    http.Response response;
    if (query.isEmpty) {
      link = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl).getLink();
      response = await http.put(link, body: jsonEncode(body), headers: headers);
    } else {
      link = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getQuery(query)
          .getLink();
      response = await http.put(link, body: jsonEncode(body), headers: headers);
    }


    return response;
  }

  Future<http.Response> delete({
    required String url,
    required path,
  }) async {
    Uri link = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl).getLink();


    http.Response response = await http.delete(link, headers: headers);


    return response;
  }

  Future<http.Response> postWithMultiFile(
      {required String url,
      required Map data,
      required List<File> files,
      String? imageKey}) async {
    var multiPartRequest = http.MultipartRequest(
        'POST', Uri.parse('https://${AppConstantManager.baseUrl}/$url'));

    for (var image in files) {
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        imageKey ?? 'photos[]',
        stream,
        length,
        filename: basename(image.path),
      );
      multiPartRequest.files.add(multipartFile);
    }

    multiPartRequest.headers.addAll({
      'Authorization': 'Bearer ${AppSharedPreferences.getToken()}',
    });

    data.forEach((key, value) {
      multiPartRequest.fields[key.toString()] = value.toString();
    });



    http.StreamedResponse response = await multiPartRequest.send();
    final httpResponse = await http.Response.fromStream(response);


    return httpResponse;
  }

  //Using this function for all post requests
  //When the parameter does not needed set as empty value
  Future<http.Response> patch(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query}) async {
    if (query != null) {
      query = filterRequest(query);
    }

    if (body != null) {
      body = filterRequest(body);
    }

    Uri link;
    http.Response response;

    // ignore: unnecessary_null_comparison
    if (body != null && query != null && query.isNotEmpty) {
      link = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getQuery(query)
          .getLink();
      response =
          await http.patch(link, body: jsonEncode(body), headers: headers);
    } else if (query != null && query.isNotEmpty) {
      link = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getQuery(query)
          .getLink();
      response = await http.patch(link, headers: headers);
    } else {
      link = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl).getLink();
      response =
          await http.patch(link, body: jsonEncode(body), headers: headers);
    }

    if (body != null) {
    }

    return response;
  }
}
