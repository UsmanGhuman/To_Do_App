import 'package:flutter/material.dart';
import 'bottom_bar.dart';

class Calender extends StatelessWidget {
  const Calender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: CustomBottomNavBar(parentContext: context),
      body: Center(
        child: Text('Calender Page'),
      ),
    );
  }
}
