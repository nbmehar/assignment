import 'package:new_tutor/models/product_item.dart';

class CategoryModel {
  CategoryModel({
    required this.categoryName,
    required this.menuItems,
  });

  String categoryName;
  List<ProductItem> menuItems;

  factory CategoryModel.fromJson(
          Map<String, dynamic> json, String categoryName) =>
      CategoryModel(
        categoryName: categoryName,
        menuItems: List<ProductItem>.from(
            json[categoryName].map((x) => ProductItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "menuItems": List<dynamic>.from(menuItems.map((x) => x.toJson())),
      };

  /// The current total price of all items.
  int get totalPrice => menuItems.fold(0, (total, current) {
        if (current.quantity! > 0) {
          total += current.quantity! * current.price!;
        }
        return total;
      });

  List<ProductItem> getSelectedItems() {
    List<ProductItem> list = [];
    for (ProductItem item in menuItems) {
      if (item.quantity! > 0) {
        list.add(item);
      }
    }
    return list;
  }
}
