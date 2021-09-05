import 'package:flutter_application/models/home/single_product.dart';

class ProductsWithCategoryEntity {
  final String categoryName;
  final List<SingleProduct> productsList;

  ProductsWithCategoryEntity(this.categoryName, this.productsList);
}
