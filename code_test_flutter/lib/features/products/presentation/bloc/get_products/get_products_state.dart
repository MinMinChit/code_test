part of 'get_products_cubit.dart';

@immutable
sealed class GetProductsState {}

final class GetProductsInitial extends GetProductsState {}

final class GetProductsLoading extends GetProductsState {}

final class GetProductsSuccess extends GetProductsState {
  final List<ProductModel> productList;
  GetProductsSuccess({required this.productList});
}

final class GetProductsFail extends GetProductsState {
  final String message;
  GetProductsFail({required this.message});
}
