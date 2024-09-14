import 'package:code_test_flutter/features/products/model/product_model.dart';
import 'package:code_test_flutter/features/products/presentation/bloc/delete_products/delete_products_cubit.dart';
import 'package:code_test_flutter/features/products/presentation/bloc/get_products/get_products_cubit.dart';
import 'package:code_test_flutter/features/products/presentation/screens/add_product_screen.dart';
import 'package:code_test_flutter/features/products/presentation/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    BlocProvider.of<GetProductsCubit>(context).getAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Test Simple UI'),
        backgroundColor: Colors.cyan,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddProductScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<GetProductsCubit>(context).getAllProduct();
          return Future.value();
        },
        child: BlocListener<DeleteProductsCubit, DeleteProductsState>(
          listener: (BuildContext context, state) {
            switch (state) {
              case DeleteProductsLoading():
                showLoadingDialog(context, 'Deleting ${state.productName}');
              case DeleteProductsSuccess():
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductScreen()),
                  (Route<dynamic> route) => false,
                );
                BlocProvider.of<GetProductsCubit>(context).getAllProduct();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Deleting product success.'),
                  ),
                );
              case DeleteProductsFail():
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Deleting product fail : ${state.message}'),
                  ),
                );
              case DeleteProductsInitial():
            }
          },
          child: BlocBuilder<GetProductsCubit, GetProductsState>(
            builder: (BuildContext context, state) {
              switch (state) {
                case GetProductsInitial():
                  return const SizedBox.shrink();
                case GetProductsLoading():
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                case GetProductsSuccess():
                  List<ProductModel> productList = state.productList;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    itemCount: productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProductModel productModel = productList[index];
                      return Container(
                        margin: const EdgeInsets.only(top: 4, bottom: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 0),
                                color: Colors.grey,
                                blurRadius: 1,
                              )
                            ]),
                        child: Row(
                          children: [
                            Text(productModel.name),
                            const Spacer(),
                            Text('${productModel.price}\$'),
                            const SizedBox(width: 6),
                            IconButton(
                              onPressed: () {
                                BlocProvider.of<DeleteProductsCubit>(context)
                                    .deleteProductById(productModel);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                case GetProductsFail():
                  return Center(
                    child: Text(state.message),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
