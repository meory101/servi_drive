/// created by eng nour othman ***
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../resource/constant_manager.dart';
import '../storage/shared/shared_pref.dart';
import 'api_url.dart';

class ApiMethods {
  late Map<String, String> headers;
  final bool? isSecondBaseUrl;

  ApiMethods({Map<String, String>? header, this.isSecondBaseUrl}) {
    if (header == null) {
      headers = {
        "Content-type": "application/json",
        "Accept": "application/json",
      };
      if (AppSharedPreferences.getToken().isNotEmpty) {
        // print(AppSharedPreferences.getToken());
        headers['Authorization'] = 'Bearer ${AppSharedPreferences.getToken()}';
      }
    } else {
      headers = header;
    }
    print('Headerssssssssssssssssssssssssssssssssssssssssssssssssss');

    print(headers);
    print('Headerssssssssssssssssssssssssssssssssssssssssssssssssss');
  }

  //Filter Map From Incorrect Or Empty Values Function
  //with deafult value for each data type
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
    //Looping To Check Also The Objeccts Inside The Request
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

  // Helper method to print formatted logs
  void _printLog(String method, String url, Map<String, String>? headers, dynamic body, http.Response? response) {
    print('\n' + '=' * 80);
    print('🌐 API $method REQUEST');
    print('=' * 80);

    // Print URL
    print('📡 URL:');
    print('   $url');
    print('');

    // Print Headers
    if (headers != null && headers.isNotEmpty) {
      print('📋 HEADERS:');
      headers.forEach((key, value) {
        print('   $key: $value');
      });
      print('');
    }

    // Print Request Body
    if (body != null) {
      print('📦 REQUEST BODY:');
      if (body is Map) {
        print('   ${JsonEncoder.withIndent('   ').convert(body)}');
      } else {
        print('   $body');
      }
      print('');
    }

    // Print Response
    if (response != null) {
      print('📥 RESPONSE:');
      print('   Status Code: ${response.statusCode}');
      print('   Status Message: ${response.reasonPhrase}');
      print('');

      // Print Response Headers
      if (response.headers.isNotEmpty) {
        print('📋 RESPONSE HEADERS:');
        response.headers.forEach((key, value) {
          print('   $key: $value');
        });
        print('');
      }

      // Print Response Body
      if (response.body.isNotEmpty) {
        print('📦 RESPONSE BODY:');
        try {
          // Try to format as JSON
          final jsonResponse = json.decode(response.body);
          print('   ${JsonEncoder.withIndent('   ').convert(jsonResponse)}');
        } catch (e) {
          // If not JSON, print as string
          print('   ${response.body}');
        }
      }
    }

    print('=' * 80);
    print('');
  }

  //Using this function for all get requests
  //When the parameter does not needed set as empty value
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

    Uri finalUri;
    if (path != null && query != null && query.isNotEmpty && path.isNotEmpty) {
      finalUri = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getPath(path)
          .getQuery(query)
          .getLink();
    } else if (query != null && query.isNotEmpty) {
      finalUri = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getQuery(query)
          .getLink();
    } else if (path != null && path.isNotEmpty) {
      finalUri = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getPath(path)
          .getLink();
    } else {
      finalUri = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl).getLink();
    }

    // Print request log
    _printLog('GET', finalUri.toString(), newHeaders, null, null);

    final response = await http.get(finalUri, headers: newHeaders);

    // Print response log
    _printLog('GET', finalUri.toString(), null, null, response);

    return response;
  }

  //Using this function for all post requests
  //When the parameter does not needed set as empty value
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
    Uri finalUri;
    if (body != null && query != null && query.isNotEmpty) {
      finalUri = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getQuery(query)
          .getLink();
    } else if (query != null && query.isNotEmpty) {
      finalUri = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getQuery(query)
          .getLink();
    } else {
      finalUri = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl).getLink();
    }

    // Print request log
    _printLog('POST', finalUri.toString(), headers, body, null);

    final response = await http.post(finalUri,
        body: body != null ? jsonEncode(body) : null, headers: headers);

    // Print response log
    _printLog('POST', finalUri.toString(), null, null, response);

    return response;
  }

  //Using this function for all pu requests
  //When the parameter does not needed set as empty value
  Future<http.Response> put(
      {required String url, body, required Map<String, dynamic> query}) async {
    query = filterRequest(query);
    Uri finalUri;
    if (query.isEmpty) {
      finalUri = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl).getLink();
    } else {
      finalUri = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getQuery(query)
          .getLink();
    }

    // Print request log
    _printLog('PUT', finalUri.toString(), headers, body, null);

    final response = await http.put(finalUri, body: jsonEncode(body), headers: headers);

    // Print response log
    _printLog('PUT', finalUri.toString(), null, null, response);

    return response;
  }

  Future<http.Response> delete({
    required String url,
    required path,
  }) async {
    headers.removeWhere((key, value) => key.toLowerCase() == 'content-type');
    Uri finalUri = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl).getLink();

    // Print request log
    _printLog('DELETE', finalUri.toString(), headers, null, null);

    final response = await http.delete(finalUri, headers: headers, body: {});

    // Print response log
    _printLog('DELETE', finalUri.toString(), null, null, response);

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

    // Print request log
    print('\n' + '=' * 80);
    print('🌐 API POST MULTIFILE REQUEST');
    print('=' * 80);
    print('📡 URL:');
    print('   ${multiPartRequest.url}');
    print('');
    print('📋 HEADERS:');
    multiPartRequest.headers.forEach((key, value) {
      print('   $key: $value');
    });
    print('');
    print('📦 FILES:');
    print('   ${files.length} files to upload');
    files.forEach((file) {
      print('   - ${basename(file.path)}');
    });
    print('');
    print('📦 FIELDS:');
    data.forEach((key, value) {
      print('   $key: $value');
    });
    print('=' * 80);
    print('');

    http.StreamedResponse streamedResponse = await multiPartRequest.send();
    final response = await http.Response.fromStream(streamedResponse);

    // Print response log
    _printLog('POST MULTIFILE', multiPartRequest.url.toString(), null, null, response);

    return response;
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
    Uri finalUri;
    if (body != null && query != null && query.isNotEmpty) {
      finalUri = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getQuery(query)
          .getLink();
    } else if (query != null && query.isNotEmpty) {
      finalUri = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl)
          .getQuery(query)
          .getLink();
    } else {
      finalUri = ApiUrl(url, useSecondBaseUrl: isSecondBaseUrl).getLink();
    }

    // Print request log
    _printLog('PATCH', finalUri.toString(), headers, body, null);

    final response = await http.put(finalUri,
        body: body != null ? jsonEncode(body) : null, headers: headers);

    // Print response log
    _printLog('PATCH', finalUri.toString(), null, null, response);

    return response;
  }
}
