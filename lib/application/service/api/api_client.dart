import 'package:dio/dio.dart';
import 'package:shopping_cart/application/constants/app_constants.dart';

class ApiClient {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
  Future<Response> get(String path) async {
    return dio.get(path);
  }
}
