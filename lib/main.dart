import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_tutor/screens/categories_screen.dart';
import 'package:provider/provider.dart';
import 'package:new_tutor/models/product_item.dart';
import 'package:new_tutor/provider/products_provider/products_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductItemAdapter());
  await Hive.openBox<ProductItem>('menu_items');
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tutorbin',
      debugShowCheckedModeBanner: false,
      home: CategoriesScreen(),
    );
  }
}
