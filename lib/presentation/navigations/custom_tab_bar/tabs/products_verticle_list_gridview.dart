import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application/models/home/products_with_category_entity.dart';
import 'package:flutter_application/models/home/products_with_catergory_list.dart';
import 'package:flutter_application/presentation/navigations/custom_tab_bar/tabs/widgets/single_grid_item.dart';

class ProductsVerticleListGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductsVerticleListGridViewWidget(
      productsWithCategoryList: productsWithCategoryList,
    );
  }
}

class ProductsVerticleListGridViewWidget extends StatelessWidget {
  final List<ProductsWithCategoryEntity> productsWithCategoryList;

  const ProductsVerticleListGridViewWidget({
    Key? key,
    required this.productsWithCategoryList,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: productsWithCategoryList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  productsWithCategoryList[index].categoryName,
                ),
              ),
            ),
            GridView.builder(
              itemCount: 12,
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 160,
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int horizantalIndex) {
                return singleGridItem(
                  horizantalIndex,
                  productsWithCategoryList[index].productsList,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
