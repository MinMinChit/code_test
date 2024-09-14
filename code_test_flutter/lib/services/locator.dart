import 'package:code_test_flutter/features/products/data/product_services.dart';
import 'package:code_test_flutter/features/products/presentation/bloc/add_products/add_products_cubit.dart';
import 'package:code_test_flutter/features/products/presentation/bloc/delete_products/delete_products_cubit.dart';
import 'package:code_test_flutter/features/products/presentation/bloc/get_products/get_products_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void locator() {
  // product
  getIt.registerLazySingleton(() => ProductServices());
  getIt.registerLazySingleton(() => GetProductsCubit(getIt.call()));
  getIt.registerLazySingleton(() => AddProductsCubit(getIt.call()));
  getIt.registerLazySingleton(() => DeleteProductsCubit(getIt.call()));
}
