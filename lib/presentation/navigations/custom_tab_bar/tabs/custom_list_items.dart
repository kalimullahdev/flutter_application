import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application/models/numbers/custom_entity.dart';
import 'package:flutter_application/models/numbers/custom_list_entity.dart';
import 'package:flutter_application/models/numbers/list_of_number_list.dart';

class CustomListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomListItemWithNumber(
      listOfNumbersList: listOfNumbersList,
    );
  }
}

class CustomListItemWithNumber extends StatelessWidget {
  final List<CustomListEntity> listOfNumbersList;

  const CustomListItemWithNumber({
    Key? key,
    required this.listOfNumbersList,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: listOfNumbersList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  listOfNumbersList[index].typeOfNumbers,
                ),
              ),
            ),
            GridView.builder(
              itemCount: 12,
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 70,
                crossAxisCount: 6,
              ),
              itemBuilder: (BuildContext context, int horizantalIndex) {
                return singleItem(
                  horizantalIndex,
                  listOfNumbersList[index].listOfEntities,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

Card singleItem(
  int index,
  List<CustomEntity> myListOfEntities,
) {
  return Card(
    color: const Color(0xff303030),
    child: Center(
      child: Text(myListOfEntities[index].value),
    ),
  );
}
