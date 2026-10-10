import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:payment_app/utils/color_page.dart';
import 'package:payment_app/category/create_category.dart';

import 'category_model.dart';

// import 'home_screen.dart';
// import 'local_storage.dart';
class Items {
  static void myDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  child: Column(
                    spacing: 10,
                    children: [
                      Text('Choose Category', style: TextStyle(fontSize: 16,color: UIColor.iconChooseColor.withAlpha(222),fontWeight: FontWeight.w700)),
                      Divider(),
                      ValueListenableBuilder(
                        valueListenable: Hive.box<CategoryModel>('category').listenable(),
                        builder: (context, Box<CategoryModel> box, _) {
                          return Wrap(
                            spacing: 40,
                            runSpacing: 20,
                            children: box.values.map((category) {
                              return Column(
                                spacing: 5,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    color: Color(category.colorValue),
                                    ),
                                    width: 70,
                                    height: 70,
                                    child: Icon(
                                      IconData(category.iconCode, fontFamily: 'MaterialIcons'),
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(category.name),
                                ],
                              );
                            }).toList(),
                          );
                        },
                      ),

                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateCategory(),
                            ),
                          );
                        },
                        label: Text(
                          'Add Category',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        iconAlignment: IconAlignment.end,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          backgroundColor: UIColor.pinksColor,
                          foregroundColor: UIColor.whiteColor,
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
//95487964