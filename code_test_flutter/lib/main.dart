import 'package:code_test_flutter/features/products/presentation/screens/product_screen.dart';
import 'package:code_test_flutter/services/bloc_register.dart';
import 'package:code_test_flutter/services/locator.dart';
import 'package:flutter/material.dart';

void main() {
  locator();
  runApp(const CodeTestApp());
}

class CodeTestApp extends StatelessWidget {
  const CodeTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocRegister(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductScreen(),
      ),
    );
  }
}
