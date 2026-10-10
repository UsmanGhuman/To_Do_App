import 'package:flutter/material.dart';
import 'package:payment_app/my_function.dart';
import 'category/category.dart';
import 'utils/color_page.dart';
// import 'package:payment_app/calender.dart';
// import 'package:payment_app/profile_page.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'home_screen.dart';


ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);

class CustomBottomNavBar extends StatelessWidget {
  final BuildContext parentContext;

  const CustomBottomNavBar({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndexNotifier,
      builder: (context, currentIndex, child) {
        return BottomAppBar(
          color: UIColor.whiteColor,
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context,
                        //   MaterialPageRoute(builder: (context)=>HomeScreen())
                        // );
                        currentIndexNotifier.value = 0;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/home-2.png',
                            scale: 4,
                            color: UIColor.blackColor.withAlpha(101),
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                              color:  UIColor.blackColor.withAlpha(101),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=>Calender())
                        // );
                        currentIndexNotifier.value = 1;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/calendar.png',
                            scale: 4,
                            color:  UIColor.blackColor.withAlpha(101),
                          ),
                          Text(
                            "Calendar",
                            style: TextStyle(
                              color: UIColor.blackColor.withAlpha(101),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        MyFunction.myFunction(context);
                      },
                      shape: OvalBorder(),
                      backgroundColor: UIColor.floatingColor,
                      foregroundColor: UIColor.whiteColor,
                      child: Icon(Icons.add),
                    ),
                    GestureDetector(
                      onTap: () {
                        currentIndexNotifier.value = 2;
                        Items.myDialog(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/clock.png',
                            scale: 4,
                            color:  UIColor.blackColor.withAlpha(101),
                          ),
                          Text(
                            "Focus",
                            style: TextStyle(
                              color: UIColor.blackColor.withAlpha(101),
                            ),
                          ),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        currentIndexNotifier.value = 3;
                        Navigator.pop(context);
                        // Navigator.pushReplacement(
                        //   parentContext,
                        //   MaterialPageRoute(
                        //     builder: (context) => ProfilePage(),
                        //   ),
                        // );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/user.png',
                            scale: 4,
                            color: UIColor.blackColor.withAlpha(101),
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color:  UIColor.blackColor.withAlpha(101),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}







































