import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:new_tutor/models/product_item.dart';
import 'package:new_tutor/models/category_model.dart';

class ProductsProvider extends ChangeNotifier {
  late Box<ProductItem> menuBox;

  final List<CategoryModel> _items = [];

  UnmodifiableListView<CategoryModel> get menuItems =>
      UnmodifiableListView(_items);

  int get totalPrice =>
      _items.fold(0, (total, current) => total + current.totalPrice);

  ProductsProvider() {
    getPopularCategories();
    getMenu();
  }

  Future<void> openHiveBoxes() async {
    try {
      menuBox = await Hive.openBox<ProductItem>('menu_items');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> getMenu() async {
    final String response = await rootBundle.loadString('assets/menu.json');
    final data = await json.decode(response);
    for (int i = 0; i < data.length; i++) {
      String categoryName = "cat${i + 1}";
      _items.add(CategoryModel.fromJson(data, categoryName));
    }
    notifyListeners();
  }

  Future<void> getPopularCategories() async {
    try {
      var menuItems = Hive.box<ProductItem>("menu_items");
      if (menuItems.isOpen) {
        _items.clear();
        List<ProductItem> list = menuItems.values.toList().cast<ProductItem>();
        if (list.isNotEmpty) {
          list.sort((a, b) => b.quantity!.compareTo(a.quantity!));
          int len = list.length > 3 ? 3 : list.length;
          CategoryModel model = CategoryModel(
              categoryName: "Popular items",
              menuItems: list.getRange(0, len).toList());
          model.menuItems.first.isBestseller = true;
          for (ProductItem item in model.menuItems) {
            item.quantity = 0;
          }
          _items.add(model);
        }
      } else {
        openHiveBoxes();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  List<ProductItem> getSelectedItems() {
    List<ProductItem> list = [];
    for (CategoryModel item in menuItems) {
      if (item.getSelectedItems().isNotEmpty) {
        list.addAll(item.getSelectedItems());
      }
    }
    return list;
  }

  Future<bool> saveOrderDetails() async {
    try {
      await Hive.openBox<ProductItem>('menu_items');
      var menuItemBox = Hive.box<ProductItem>('menu_items');
      List<ProductItem> list = getSelectedItems();
      for (ProductItem menu in list) {
        ProductItem model = ProductItem()
          ..quantity = menu.quantity
          ..isBestseller = false
          ..name = menu.name
          ..instock = menu.instock
          ..price = menu.price;

        menuItemBox.add(model);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  resetQuantity() {
    getPopularCategories();
    getMenu();
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
