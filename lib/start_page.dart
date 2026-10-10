// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:payment_app/login_page.dart';
import 'package:payment_app/onboarding/slider_screen.dart';
// import 'package:payment_app/slider_screen.dart';
import 'utils/color_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/emg.png')
          ,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Image.asset('images/img2.png'),
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Task Management &\n To-Do-List',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'This productive tool is designed to help\n you better manage your task \n project-wise conveniently!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: UIColor.secondaryColor),
              ),
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>SliderScreen())
                  );
                },
                // label: Text('Let\'s Start',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                // icon: Icon(Icons.arrow_forward),
                // iconAlignment: IconAlignment.end,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  backgroundColor: UIColor.pinkColor,
                  foregroundColor: UIColor.whiteColor,
                  minimumSize: Size(double.infinity, 50),
                  maximumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox.shrink(),
                    SizedBox.shrink(),
                    Text('Let\'s Start',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600),),
                    Image.asset('images/Arrow.png',scale: 4,width: 24,height: 24,)
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
