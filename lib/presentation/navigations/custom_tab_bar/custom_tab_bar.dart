import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/navigations/custom_tab_bar/tabs/custom_list_items.dart';
import 'package:flutter_application/presentation/navigations/custom_tab_bar/tabs/products_gridview.dart';
import 'package:flutter_application/presentation/navigations/custom_tab_bar/tabs/products_listview.dart';
import 'package:flutter_application/presentation/navigations/custom_tab_bar/tabs/products_verticle_list_gridview.dart';
import 'package:flutter_application/presentation/navigations/custom_tab_bar/tabs/products_with_category_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTabBar extends ConsumerWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            bottom: const TabBar(
              indicatorColor: Color(0xff019589),
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              tabs: [
                Tab(child: Text("For you")),
                Tab(child: Text("Top charts")),
                Tab(child: Text("Kids")),
                Tab(child: Text("Premium")),
                Tab(child: Text("Categories")),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ProductsListview(),
            ProductsWithCatergoyView(),
            ProductsGridview(),
            ProductsVerticleListGridView(),
            CustomListItem(),
          ],
        ),
      ),
    );
  }
}
