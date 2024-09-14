part of 'delete_products_cubit.dart';

@immutable
sealed class DeleteProductsState {}

final class DeleteProductsInitial extends DeleteProductsState {}

final class DeleteProductsLoading extends DeleteProductsState {
  final String productName;
  DeleteProductsLoading({required this.productName});
}

final class DeleteProductsSuccess extends DeleteProductsState {}

final class DeleteProductsFail extends DeleteProductsState {
  final String message;

  DeleteProductsFail({required this.message});
}
