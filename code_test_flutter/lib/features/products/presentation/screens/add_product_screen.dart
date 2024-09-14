import 'package:code_test_flutter/features/products/model/product_model.dart';
import 'package:code_test_flutter/features/products/presentation/bloc/add_products/add_products_cubit.dart';
import 'package:code_test_flutter/features/products/presentation/bloc/get_products/get_products_cubit.dart';
import 'package:code_test_flutter/features/products/presentation/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/loading_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController discountCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
        backgroundColor: Colors.cyanAccent,
      ),
      body: BlocListener<AddProductsCubit, AddProductsState>(
        listener: (BuildContext context, state) {
          switch (state) {
            case AddProductsInitial():
            case AddProductsLoading():
              showLoadingDialog(context, 'Adding new product...');
            case AddProductsSuccess():
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const ProductScreen()),
                (Route<dynamic> route) => false,
              );
              BlocProvider.of<GetProductsCubit>(context).getAllProduct();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Add new product success.'),
                ),
              );
            case AddProductsFail():
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Add new product fail : ${state.message}'),
                ),
              );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Expanded(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameCtrl,
                        decoration: const InputDecoration(
                          label: Text('Product Name'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "required product name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: priceCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Product Price'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "required product price";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: discountCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Product Discount'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<AddProductsCubit>(context)
                          .addProduct(ProductModel(
                        name: nameCtrl.text,
                        price: int.tryParse(priceCtrl.text) ?? 0,
                        discount: int.tryParse(discountCtrl.text) ?? 0,
                      ));
                    }
                  },
                  child: const Text('Add Product'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
