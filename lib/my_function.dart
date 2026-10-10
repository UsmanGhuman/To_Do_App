import 'package:flutter/material.dart';
import 'package:payment_app/home/app_model.dart';
import 'package:payment_app/boxes.dart';
import 'utils/color_page.dart';

class MyFunction {
  static void myFunction(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController status = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                spacing: 10,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Add Task',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: UIColor.blackColor.withAlpha(201),
                      ),
                    ),
                  ),
                  TextField(
                    controller: title,
                    cursorColor: UIColor.blackColor,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: description,
                    cursorColor: UIColor.blackColor,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: status,
                    cursorColor: UIColor.blackColor,
                    decoration: InputDecoration(
                      hintText: 'Status',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 20,
                        children: [
                          Image.asset('images/timer.png', width: 20),
                          Image.asset('images/tag.png', width: 20),
                          Image.asset('images/flag.png', width: 20),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              final data = AppModel(
                                title: title.text,
                                description: description.text,
                                status: status.text,
                              );
                              final box = Boxes.getData();
                              box.add(data);
                              data.save();
                              title.clear();
                              description.clear();
                              status.clear();
                              Navigator.pop(context);
                            },
                            child: Image.asset('images/send.png', width: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
//hello how are you can we go for a Lunch Tomorrow if you do not mind
