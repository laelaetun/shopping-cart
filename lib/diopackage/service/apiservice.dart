import 'package:dio/dio.dart';
import 'package:shopping_cart/diopackage/model/users.dart';

class ApiService {
  final Dio dio = Dio();
  Future<List<Users>> getProducts() async {
    try {
      final response = await dio.get("https://fakestoreapi.com/products");

      final List<dynamic> result = response.data;

      final List<Users> product = result.map((e) => Users.fromJson(e)).toList();

      return product;
    } on DioException catch (e) {
      print("Dio Error: ${e.response?.data}");
      return [];
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  //add new products
  Future<Users?> addProduct(Users newProduct) async {
    try {
      final response = await dio.post(
        "https://fakestoreapi.com/products",
        data: newProduct.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Users.fromJson(response.data);
      } else {
        print("Failed to add product: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.response?.data}");
      return null;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  //delete products
  Future<void> deleteProduct(int id) async {
    try {
      final response = await dio.delete(
        "https://fakestoreapi.com/products/$id",
      );

      if (response.statusCode == 200) {
        print("Product deleted successfully");
      } else {
        print("Failed to delete product: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.response?.data}");
    } catch (e) {
      print("Error: $e");
    }
  }

  //update products
  Future<List<Users>?> updateProduct(Users updatedProduct, int id) async {
    try {
      final response = await dio.put(
        "https://fakestoreapi.com/products/$id",
        data: updatedProduct.toJson(),
      );

      if (response.statusCode == 200) {
        return getProducts();
      } else {
        print("Failed to update product: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.response?.data}");
      return null;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
