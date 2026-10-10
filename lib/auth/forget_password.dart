import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_app/utils/color_page.dart';
import 'package:payment_app/controllers/forget_password_controller.dart';
import 'package:payment_app/utils/utils.dart';
import 'login_page.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  // bool loading = false;
  final ForgetPasswordController controller = Get.put(
    ForgetPasswordController(),
  );
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Forget\nPassword?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  height: 1,
                ),
              ),
            ),
            SizedBox(height: 30),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: emailController,
                cursorColor: UIColor.hintColor,
                decoration: InputDecoration(
                  fillColor: UIColor.fieldColor,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.email,
                    color: UIColor.blackColor.withAlpha(156),
                  ),
                  labelText: 'Enter your Email Address',
                  labelStyle: TextStyle(
                    color: UIColor.hintColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  hintText: 'Enter your Email Address',
                  hintStyle: TextStyle(
                    color: UIColor.hintColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Email';
                  }
                  if (!value.endsWith('@gmail.com')) {
                    return 'Use @gmail.com at the end';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: UIColor.hintColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: '* ',
                    style: TextStyle(color: UIColor.pinkColor),
                  ),
                  TextSpan(
                    text:
                        'We will send you a message to set or reset your new password',
                  ),
                ],
              ),
            ),
            SizedBox(height: 70),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  controller.setLoading(true);

                  _auth
                      .sendPasswordResetEmail(
                        email: emailController.text.toString(),
                      )
                      .then((value) {
                        Utils().toastMessage(
                          'Email send Successfully to recover Password',
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (route) => false,
                        );
                        controller.setLoading(false);
                      })
                      .onError((error, stackTrace) {
                        Utils().toastMessage('Invalid Email');
                        controller.setLoading(false);
                      });
                }
              },
              label: Obx(
                () => controller.loading.value
                    ? CircularProgressIndicator(
                        strokeWidth: 4,
                        color: Colors.white,
                      )
                    : Text(
                        'Send',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                backgroundColor: UIColor.pinkColor,
                foregroundColor: UIColor.whiteColor,
                minimumSize: Size(double.infinity, 50),
                maximumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
