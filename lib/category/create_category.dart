import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:payment_app/utils/color_page.dart';
// import 'package:payment_app/home_screen.dart';

import 'category_model.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
  Color?  selectedColor;
  void _showIconPicker() {
    List<IconData> icons = [
      Icons.home,
      Icons.shopping_cart,
      Icons.fastfood,
      Icons.car_rental,
      Icons.flight,
      Icons.movie,
      Icons.school,
      Icons.work,
      Icons.favorite,
      Icons.music_note,
    ];

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: icons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIcon = icons[index];
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(21),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icons[index], size: 30, color: Colors.black),
                ),
              );
            },
          ),
        );
      },
    );
  }

  IconData? selectedIcon;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
              bottom: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Category',
                      style: TextStyle(
                        fontSize: 20,
                        color: UIColor.iconChooseColor.withAlpha(222),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Category name:',
                      style: TextStyle(
                        color: UIColor.iconChooseColor.withAlpha(222),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: nameController,
                      cursorColor: UIColor.blackColor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: UIColor.greyColor.withAlpha(51),
                        hintText: 'Category name',
                        hintStyle: TextStyle(color: Color(0xFFAFAFAF)),
                        focusColor: UIColor.greyColor,
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Category icon:',
                      style: TextStyle(
                        color: UIColor.iconChooseColor.withAlpha(222),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UIColor.greyColor.withAlpha(51),
                        foregroundColor: Color(0xFF3B3B3B).withAlpha(222),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        _showIconPicker();
                      },
                      child: Text('Choose icon from library',style: TextStyle(color: UIColor.iconChooseColor.withAlpha(222)),),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Category color:',
                      style: TextStyle(
                        color: UIColor.blackColor.withAlpha(157),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = Colors.primaries[index];
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.primaries[index],
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 200),
                // Spacer(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox.shrink(),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          label: Text(
                            'Cancel',
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
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: UIColor.floatingColor,
                            minimumSize: Size(153, 48),
                            maximumSize: Size(153, 48),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (nameController.text.isEmpty ||
                                selectedIcon == null ||
                                selectedColor == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Please select name, icon and color")),
                              );
                              return;
                            }

                            var box = Hive.box<CategoryModel>('category');

                            box.add(
                              CategoryModel(
                                name: nameController.text,
                                iconCode: selectedIcon!.codePoint,
                                colorValue: selectedColor!.value,
                              ),
                            );

                            Navigator.pop(context);
                          },
                          // onPressed: () {
                          //   var box = Hive.box<CategoryModel>('category');
                          //
                          //   box.add(
                          //     CategoryModel(
                          //       name:
                          //           nameController.text, // you need controller
                          //       iconCode: selectedIcon!.codePoint,
                          //       colorValue: selectedColor!.value,
                          //     ),
                          //   );
                          //
                          //   Navigator.pop(context);
                          //   // Navigator.push(context,
                          //   //   MaterialPageRoute(builder: (context)=>HomeScreen())
                          //   // );
                          // },
                          label: Text(
                            'Add Category',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          iconAlignment: IconAlignment.end,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12,horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            backgroundColor: UIColor.pinkColor,
                            foregroundColor: UIColor.whiteColor,
                            minimumSize: Size(153, 48),
                            maximumSize: Size(153, 48),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
