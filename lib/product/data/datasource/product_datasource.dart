import 'package:shopping_cart/application/constants/app_constants.dart';
import 'package:shopping_cart/application/service/api/api_client.dart';
import 'package:shopping_cart/product/data/model/product_model.dart';

class ProductDatasource {
  final ApiClient apiClient;
  ProductDatasource(this.apiClient);
  Future<List<ProductModel>> fetchProduct() async {
    final response = await apiClient.get(AppConstants.products);
    if (response.statusCode == 200) {
      print("success");
    } else {
      print("failed");
    }
    final result = response.data as List;

    final data = result.map((e) => ProductModel.fromJson(e)).toList();
    return data;
  }
}
// class ProductDatasource {
//   final ApiClient apiClient;

//   ProductDatasource(this.apiClient);

//   Future<List<ProductModel>> fetchProduct() async {
//     try {
//       final response = await apiClient.get(AppConstants.products);

//       if (response.statusCode == 200) {
//         final result = response.data as List;
//         final data = result.map((e) => ProductModel.fromJson(e)).toList();

//         return data;
//       } else {
//         throw Exception("Failed to load data");
//       }
//     } catch (e) {
//       throw Exception("Datasource error");
//     }
//   }
// }
