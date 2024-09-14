import 'dart:convert';
import 'dart:io';

import 'package:code_test_flutter/constants/constants.dart';
import 'package:code_test_flutter/features/products/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  Future getAllProducts() async {
    final response = await http.get(
      Uri.parse('${KConstant.testUrl}/products/items'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    return response;
  }

  Future addProduct(ProductModel requestModel) async {
    final response = await http.post(
      Uri.parse('${KConstant.testUrl}/products/items'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(requestModel),
    );

    return response;
  }

  Future deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse('${KConstant.testUrl}/products/items/$id'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    return response;
  }
}
