import 'package:code_test_flutter/features/products/presentation/bloc/add_products/add_products_cubit.dart';
import 'package:code_test_flutter/features/products/presentation/bloc/delete_products/delete_products_cubit.dart';
import 'package:code_test_flutter/features/products/presentation/bloc/get_products/get_products_cubit.dart';
import 'package:code_test_flutter/services/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocRegister extends StatelessWidget {
  const BlocRegister({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetProductsCubit(getIt.call())),
        BlocProvider(create: (context) => AddProductsCubit(getIt.call())),
        BlocProvider(create: (context) => DeleteProductsCubit(getIt.call()))
      ],
      child: child,
    );
  }
}
