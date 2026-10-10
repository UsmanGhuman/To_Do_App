
import 'package:hive/hive.dart';
part 'app_model.g.dart';
@HiveType(typeId: 0)

class AppModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String status;

  AppModel({required this.title,required this.description,required this.status,});
}