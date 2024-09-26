import 'package:dio/dio.dart';

import '../config_data/configuration_data.dart';
import '../service_locator/service_locator.dart';

class ConnectionHelper {

  ConnectionHelper() {
    dio.options.baseUrl = serviceLocator.get<ConfigurationData>().baseUrl;
    dio.options.contentType = serviceLocator.get<ConfigurationData>().contentType;
  }

  final dio = Dio();

  void setBaseUrl(String url) {
    dio.options.baseUrl = url;
  }

  void setContentType(String contentType) {
    dio.options.contentType = contentType;
  }
}