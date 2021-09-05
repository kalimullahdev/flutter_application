import 'package:flutter_application/models/numbers/custom_entity.dart';

class CustomListEntity {
  final String typeOfNumbers;
  final List<CustomEntity> listOfEntities;

  CustomListEntity(this.typeOfNumbers, this.listOfEntities);
}
