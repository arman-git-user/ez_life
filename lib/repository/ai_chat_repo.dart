import 'package:ez_life/data/network/base_url_services.dart';
import 'package:ez_life/data/network/network_url_services.dart';
import 'package:ez_life/utils/base_url.dart';

class AiChatRepo {
  BaseUrlServices apiServices = NetworkUrlServices();

  Future<dynamic> promptAI(dynamic data) async {
    try {
      dynamic rawData  = await apiServices.postAPIServices(
        BaseUrl.baseUrl,
        data,
      );
      final response = rawData['candidates'][0]['content']['parts'][0]['text'];
      print(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
