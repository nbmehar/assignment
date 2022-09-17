import 'package:hive/hive.dart';
part 'product_item.g.dart';

@HiveType(typeId: 2)
class ProductItem extends HiveObject {
  ProductItem(
      {this.name,
      this.price,
      this.instock,
      this.quantity,
      this.isBestseller = false});

  @HiveField(0)
  String? name;
  @HiveField(1)
  int? price;
  @HiveField(2)
  bool? instock;
  @HiveField(3)
  int? quantity;
  bool? isBestseller;

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
      name: json["name"],
      price: json["price"],
      instock: json["instock"],
      quantity: 0);

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "instock": instock,
        "quantity": quantity,
      };

  void add() {
    quantity = quantity! + 1;
  }

  void remove() {
    quantity = quantity! - 1;
  }
}
