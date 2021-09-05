import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application/models/home/product_list.dart';
import 'package:flutter_application/models/home/single_product.dart';
import 'package:flutter_application/presentation/navigations/custom_tab_bar/tabs/widgets/single_grid_item.dart';

class ProductsGridview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductsGridviwBuilder(products: productsList, showInOnLine: false);
  }
}

class ProductsGridviwBuilder extends StatelessWidget {
  const ProductsGridviwBuilder({
    Key? key,
    required this.products,
    required this.showInOnLine,
  }) : super(key: key);
  final List<SingleProduct> products;
  final bool showInOnLine;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 140,
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        return singleGridItem(index, products);
      },
    );
  }
}
