import 'package:get_it/get_it.dart';
import 'package:shopping_cart/application/auth/auth_bloc.dart';
import 'package:shopping_cart/application/service/api/api_client.dart';
import 'package:shopping_cart/application/service/auth/firebase_auth_service.dart';
import 'package:shopping_cart/product/data/datasource/product_datasource.dart';
import 'package:shopping_cart/product/data/repository/product_repository_iml.dart';
import 'package:shopping_cart/product/domain/repository/product_repository.dart';
import 'package:shopping_cart/product/domain/usecases/get_product_usecase.dart';
import 'package:shopping_cart/product/presentation/bloc/product_bloc.dart';

final getIt = GetIt.instance;

class Injection {
  static Future<void> init() async {
    // auth
    getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
    //auth bloc
    getIt.registerLazySingleton<AuthBloc>(
      () => AuthBloc(getIt<FirebaseAuthService>()),
    );

    //api client
    getIt.registerLazySingleton<ApiClient>(() => ApiClient());

    //data source
    getIt.registerLazySingleton<ProductDatasource>(
      () => ProductDatasource(getIt<ApiClient>()),
    );

    //repository
    getIt.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryIml(getIt<ProductDatasource>()),
    );

    //use case
    getIt.registerLazySingleton<GetProductUseCase>(
      () => GetProductUseCase(getIt<ProductRepository>()),
    );
    // product bloc
    getIt.registerFactory<ProductBloc>(
      () => ProductBloc(getIt<GetProductUseCase>()),
    );
  }
}
