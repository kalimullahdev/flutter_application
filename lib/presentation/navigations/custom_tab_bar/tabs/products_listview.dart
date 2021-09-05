import 'package:flutter/material.dart';
import 'package:flutter_application/models/home/product_list.dart';
import 'package:flutter_application/models/home/single_product.dart';

class ProductsListview extends StatefulWidget {
  @override
  _ProductsListviewState createState() => _ProductsListviewState();
}

class _ProductsListviewState extends State<ProductsListview> {
  @override
  Widget build(BuildContext context) {
    int listTileDurationNumber = 1;
    List<int> listOfDurationNumbers = [];
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: productsList.length,
      itemBuilder: (context, index) {
        final indexPlusOne = index + 1;

        if ((indexPlusOne) < listTileDurationNumber ||
            listOfDurationNumbers.contains(indexPlusOne)) {
          listTileDurationNumber = 0;
        } else {
          listTileDurationNumber = indexPlusOne;
        }

        listOfDurationNumbers.add(indexPlusOne);

        return SingleListTile(
          product: productsList[index],
          index: indexPlusOne,
          durationNumber: listTileDurationNumber,
        );
      },
    );
  }
}

class SingleListTile extends StatefulWidget {
  const SingleListTile({
    Key? key,
    required this.product,
    required this.index,
    required this.durationNumber,
  }) : super(key: key);

  final SingleProduct product;
  final int index;
  final int durationNumber;

  @override
  _SingleListTileState createState() => _SingleListTileState();
}

class _SingleListTileState extends State<SingleListTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _drawerSlideController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 180 * widget.durationNumber),
  )..forward();

  @override
  void dispose() {
    _drawerSlideController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _drawerSlideController,
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.index.toString()),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/products_icons/${widget.product.imageurl}",
                  height: 44,
                ),
              ),
            ),
          ],
        ),
        title: Text(
          widget.product.title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                widget.product.companyname,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Row(
              children: [
                Text(
                  "${widget.product.reviews} ",
                  style: const TextStyle(fontSize: 12),
                ),
                const Icon(
                  Icons.star,
                  size: 12,
                ),
                const SizedBox(width: 8),
                Text(
                  "${widget.product.size} MB",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
