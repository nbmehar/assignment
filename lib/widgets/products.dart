import 'package:flutter/material.dart';

import '../models/product_item.dart';
import '../provider/products_provider/products_provider.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  Products({Key? key, required this.list}) : super(key: key);
  List<ProductItem> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (_, index) {
          ProductItem menu = list[index];
          return Container(
            color: Colors.grey.shade100,
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 25),
            margin: const EdgeInsets.only(top: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          menu.name!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (menu.isBestseller!)
                          Container(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red),
                            child: const Text(
                              'Bestseller',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Rs. ${menu.price}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                if (menu.quantity == 0)
                  GestureDetector(
                    onTap: () {
                      menu.add();
                      context.read<ProductsProvider>().refresh();
                    },
                    child: Container(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, top: 6, bottom: 6),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(40)),
                        child: const Text(
                          'Add',
                          style: TextStyle(color: Colors.orange),
                        )),
                  ),
                if (menu.quantity! > 0)
                  Container(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (menu.quantity! > 0) {
                              menu.remove();
                              context.read<ProductsProvider>().refresh();
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 5.0, left: 5),
                            child: Icon(
                              Icons.remove,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xffFF8402)),
                          child: Center(
                            child: Text(
                              menu.quantity.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            menu.add();
                            context.read<ProductsProvider>().refresh();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5),
                            child: Icon(
                              Icons.add,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          );
        });
  }
}
