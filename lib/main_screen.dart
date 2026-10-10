import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'home/home_screen.dart';
import 'calender.dart';
import 'profile/profile_page.dart';
import 'my_function.dart';
import 'category/category.dart';
import 'utils/color_page.dart';
import 'controllers/main_screen_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainScreenController controller = Get.put(MainScreenController());

  final List<Widget> pages = [HomeScreen(), Calender(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (controller.currentIndex.value != 0) {
            controller.resetToHome();
          } else {
            SystemNavigator.pop();
          }
        },
        child: Scaffold(
          body: pages[controller.currentIndex.value],

          bottomNavigationBar: BottomAppBar(
            color: UIColor.whiteColor,
            child: SizedBox(
              height: 65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  navItem(Icons.home, "Home", 0),
                  navItem(Icons.calendar_today, "Calendar", 1),

                  FloatingActionButton(
                    onPressed: () {
                      MyFunction.myFunction(context);
                    },
                    shape: const OvalBorder(),
                    backgroundColor: UIColor.floatingColor,
                    foregroundColor: UIColor.whiteColor,
                    child: const Icon(Icons.add),
                  ),

                  GestureDetector(
                    onTap: () {
                      controller.setFocusTab();
                      Items.myDialog(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Icon(
                            Icons.access_time,
                            color: controller.selectedNav.value == 3
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                        Obx(
                          () => Text(
                            "Focus",
                            style: TextStyle(
                              color: controller.selectedNav.value == 3
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  navItem(Icons.person, "Profile", 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, String label, int index) {
    return Obx(() {
      bool isSelected = controller.selectedNav.value == index;

      return GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.red : Colors.grey),
            Text(
              label,
              style: TextStyle(color: isSelected ? Colors.red : Colors.grey),
            ),
          ],
        ),
      );
    });
  }
}
