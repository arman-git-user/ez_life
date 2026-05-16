import 'dart:convert';
import 'dart:io';

import 'package:ez_life/data/app_exceptions.dart';
import 'package:ez_life/data/network/base_url_services.dart';
import 'package:ez_life/utils/base_url.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NetworkUrlServices implements BaseUrlServices {
  @override
  Future<dynamic> getAPIServices(String url) {
    // TODO: implement getAPIServices
    throw UnimplementedError();
  }

  @override
  Future<dynamic> postAPIServices(String url, data) async {
    dynamic jsonResponse;

    Map<String, dynamic> bodyParams = {
      'contents': [
        {
          'parts': [
            {'text': data},
          ],
        },
      ],
    };
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              'x-goog-api-key': dotenv.env['API_KEY']!,
              'Content-Type': 'application/json',
            },
            body: jsonEncode(bodyParams),
          )
          .timeout(Duration(seconds: 10));
      jsonResponse = returnJsonResponse(response);
      return jsonResponse;
    } on SocketException {
      throw FetchDataException();
    }
  }

  dynamic returnJsonResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        throw BadRequestException('Invalid request');
    }
  }
}
