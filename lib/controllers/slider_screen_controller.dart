

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SliderScreenController extends GetxController {

  final PageController pageController = PageController();
  RxInt currentIndex = 0.obs;

  List<Map<String,dynamic>> imageList = [
    {'id': 1, 'image_path': 'images/img6.png'},
    {'id': 2, 'image_path': 'images/img7.png'},
    {'id': 3, 'image_path': 'images/img8.png'},
  ];

  List<Map<String, String>> contentList = [
    {
      "title": "Choose Products",
      "desc":
      "Amet minim mollit non deserunt ullamco est\n sit aliqua dolor do amet sint. Velit officia\n consequat duis enim velit mollit..",
    },
    {
      "title": "Make Payment",
      "desc":
      "Amet minim mollit non deserunt ullamco est\n sit aliqua dolor do amet sint. Velit officia \nconsequat duis enim velit mollit..",
    },
    {
      "title": "Get Your Order",
      "desc":
      "Amet minim mollit non deserunt ullamco est\n sit aliqua dolor do amet sint. Velit officia\n consequat duis enim velit mollit..",
    },
  ];

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (currentIndex < imageList.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void prevPage() {
    if (currentIndex > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void skip() {
    pageController.jumpToPage(imageList.length - 1);
  }
  int get totalPages => imageList.length;
}