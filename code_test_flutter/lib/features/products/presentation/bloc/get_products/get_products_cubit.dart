import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:code_test_flutter/features/products/data/product_services.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../../model/product_model.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  final ProductServices api;
  GetProductsCubit(this.api) : super(GetProductsInitial());

  Future getAllProduct() async {
    emit(GetProductsLoading());
    try {
      Response response = await api.getAllProducts();
      var result = json.decode(response.body);
      if (response.statusCode == 200) {
        List<ProductModel> productList =
            ProductModel.productListFromJson(result);

        emit(GetProductsSuccess(productList: productList));
      } else {
        emit(GetProductsFail(message: result['message']));
      }
    } catch (e) {
      emit(GetProductsFail(message: e.toString()));
    }
  }
}
