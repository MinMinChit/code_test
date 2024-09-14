import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:code_test_flutter/features/products/model/product_model.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../../data/product_services.dart';

part 'add_products_state.dart';

class AddProductsCubit extends Cubit<AddProductsState> {
  final ProductServices api;
  AddProductsCubit(this.api) : super(AddProductsInitial());

  Future addProduct(ProductModel requestModel) async {
    emit(AddProductsLoading());
    try {
      Response response = await api.addProduct(requestModel);
      var result = json.decode(response.body);
      if (response.statusCode == 200) {
        emit(AddProductsSuccess());
      } else {
        emit(AddProductsFail(message: result['message']));
      }
    } catch (e) {
      emit(AddProductsFail(message: e.toString()));
    }
  }
}
