import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:new_tutor/widgets/products.dart';

import '../models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, required this.model}) : super(key: key);
  final CategoryModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10)),
      child: ExpandablePanel(
          theme: const ExpandableThemeData(
              iconColor: Colors.black,
              headerAlignment: ExpandablePanelHeaderAlignment.center),
          header: Text(
            model.categoryName,
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          collapsed: const SizedBox(),
          expanded: Products(list: model.menuItems)),
    );
  }
}
