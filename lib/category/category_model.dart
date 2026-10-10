import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  int iconCode;

  @HiveField(2)
  int colorValue;

  CategoryModel({
    required this.name,
    required this.iconCode,
    required this.colorValue,
  });
}