import 'package:shopping_cart/product/data/datasource/product_datasource.dart';

import 'package:shopping_cart/product/domain/entities/product_entity.dart';
import 'package:shopping_cart/product/domain/repository/product_repository.dart';

class ProductRepositoryIml implements ProductRepository {
  final ProductDatasource productDatasource;
  ProductRepositoryIml(this.productDatasource);
  @override
  Future<List<ProductEntity>> getProducts() async {
    return productDatasource.fetchProduct();
  }
}
