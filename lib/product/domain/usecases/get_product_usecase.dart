import 'package:shopping_cart/product/domain/entities/product_entity.dart';
import 'package:shopping_cart/product/domain/repository/product_repository.dart';

class GetProductUseCase {
  final ProductRepository productRepository;
  GetProductUseCase(this.productRepository);
  Future<List<ProductEntity>> call() async {
    return await productRepository.getProducts();
  }
}
