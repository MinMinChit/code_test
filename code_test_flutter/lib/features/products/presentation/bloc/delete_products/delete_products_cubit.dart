import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:code_test_flutter/features/products/model/product_model.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../../data/product_services.dart';

part 'delete_products_state.dart';

class DeleteProductsCubit extends Cubit<DeleteProductsState> {
  final ProductServices api;
  DeleteProductsCubit(this.api) : super(DeleteProductsInitial());

  Future deleteProductById(ProductModel model) async {
    emit(DeleteProductsLoading(productName: model.name));
    // try {
    Response response = await api.deleteProduct(model.id!);
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      emit(DeleteProductsSuccess());
    } else {
      emit(DeleteProductsFail(message: result['message']));
    }
    // } catch (e) {
    //   emit(DeleteProductsFail(message: e.toString()));
    // }
  }
}
