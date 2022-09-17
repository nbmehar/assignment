import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_tutor/widgets/category_widget.dart';
import 'package:provider/provider.dart';

import '../models/category_model.dart';
import '../provider/products_provider/products_provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ProductsProvider>(builder: (_, items, child) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 100),
                itemCount: items.menuItems.length,
                itemBuilder: (_, index) {
                  CategoryModel model = items.menuItems[index];
                  return CategoryWidget(model: model);
                },
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (items.totalPrice > 0) {
                  bool saveStatus = await Provider.of<ProductsProvider>(context,
                          listen: false)
                      .saveOrderDetails();
                  if (saveStatus) {
                    refresh();
                    showSnackBar("Order is Placed");
                  } else {
                    showSnackBar("Retry, Order Failed");
                  }
                } else {
                  showSnackBar("Add some Products : )");
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xffFF8402),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      "Place Order:  \$ ${items.totalPrice}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void refresh() {
    context.read<ProductsProvider>().resetQuantity();
  }

  @override
  dispose() {
    super.dispose();
    Hive.close();
  }

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      duration: const Duration(seconds: 1),
    ));
  }
}
