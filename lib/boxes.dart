


import 'package:hive/hive.dart';
import 'package:payment_app/home/app_model.dart';

class Boxes {
  static Box<AppModel> getData() => Hive.box<AppModel>('app');
}