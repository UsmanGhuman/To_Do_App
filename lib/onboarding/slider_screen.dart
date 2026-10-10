
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_app/utils/color_page.dart';
import 'package:payment_app/controllers/slider_screen_controller.dart';
import 'package:payment_app/local_storage.dart';
import 'package:payment_app/auth/login_page.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  final SliderScreenController controller = Get.put(SliderScreenController());

  void goToLogin() async {
    await LocalStorage.setOnboarding(true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      "${controller.currentIndex.value + 1}/${controller.totalPages}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.skip,
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // const SizedBox(height: 40),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.imageList.length,
                onPageChanged: (index) {
                  controller.onPageChanged(index);
                },
                itemBuilder: (context, index) {
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 350,
                        width: double.infinity,
                        child: Image.asset(
                          controller.imageList[index]['image_path'],
                          fit: BoxFit.contain, // better than cover here
                        ),
                      ),
                      // SizedBox(height: 60),
                      Text(
                        controller.contentList[index]["title"]!,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        controller.contentList[index]["desc"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: UIColor.borderColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => controller.currentIndex.value == 0
                        ? SizedBox(width: 60)
                        : GestureDetector(
                            onTap: controller.prevPage,
                            child: Text(
                              "Prev",
                              style: TextStyle(
                                color: UIColor.greyColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.imageList.asMap().entries.map((
                        entry,
                      ) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: controller.currentIndex.value == entry.key
                              ? 20
                              : 7,
                          height: 7,
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: controller.currentIndex.value == entry.key
                                ? UIColor.blackColor
                                : UIColor.blackColor.withAlpha(51),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Obx (
                    () => GestureDetector(
                      onTap: () {
                        if (controller.currentIndex.value ==
                            controller.imageList.length - 1) {
                          goToLogin();
                        } else {
                          controller.nextPage();
                        }
                      },
                      child: Text(
                        controller.currentIndex.value ==
                                controller.imageList.length - 1
                            ? "Get Started"
                            : "Next",
                        style: TextStyle(
                          color: UIColor.pinkColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}