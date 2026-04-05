import 'package:bloc/bloc.dart';
import 'package:shopping_cart/product/domain/entities/product_entity.dart';
import 'package:shopping_cart/product/domain/usecases/get_product_usecase.dart';
import 'package:shopping_cart/product/presentation/bloc/product_event.dart';
import 'package:shopping_cart/product/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUseCase getProductUseCase;
  ProductBloc(this.getProductUseCase) : super(ProductInitial()) {
    on<ProductGetEvent>((event, emit) async {
      emit(ProductLoading());
      final List<ProductEntity> products = await getProductUseCase.call();
      emit(ProductLoaded(products));
    });
  }
}
