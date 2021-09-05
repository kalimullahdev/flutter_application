import 'package:flutter/material.dart';
import 'package:flutter_application/models/home/single_product.dart';

Card singleGridItem(
  int index,
  final List<SingleProduct> products,
) {
  return Card(
    color: const Color(0xff303030),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
                "assets/products_icons/${products[index].imageurl}"),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          child: Text(
            products[index].title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10),
          ),
        ),
        Text(
          "${products[index].size} MB",
          style: const TextStyle(fontSize: 10),
        ),
      ],
    ),
  );
}
