import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_app/utils/color_page.dart';
import 'package:payment_app/controllers/register_controller.dart';
import 'package:payment_app/local_storage.dart';
import 'package:payment_app/auth/login_page.dart';
import 'package:payment_app/utils/utils.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController registerController = Get.put(RegisterController());
  // bool loading = false;
  // bool isPasswordVisible = false;
  // bool isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create an\naccount',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: UIColor.fieldColor,
                        prefixIcon: Icon(
                          Icons.person,
                          color: UIColor.prefixColor,
                        ),
                        hintText: 'Username or Email',
                        hintStyle: TextStyle(
                          color: UIColor.hintColor,
                          fontSize: 12,
                        ),
                        labelText: 'Username or Email',
                        labelStyle: TextStyle(
                          color: UIColor.hintColor,
                          fontSize: 12,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
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
                    SizedBox(height: 30),
                    Obx(
                      () => TextFormField(
                        obscureText:
                            !registerController.isPasswordVisible.value,
                        controller: passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: UIColor.fieldColor,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: UIColor.prefixColor,
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: UIColor.hintColor,
                            fontSize: 12,
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: UIColor.hintColor,
                            fontSize: 12,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              registerController.togglePasswordVisibility();
                            },
                            child: registerController.isPasswordVisible.value
                                ? Image.asset(
                                    'images/eye.png',
                                    width: 18.33,
                                    height: 13.33,
                                  )
                                : Icon(Icons.visibility_off),
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
                            return 'Enter Password';
                          }
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return 'Password must contain at least 1 uppercase letter';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Obx(
                      () => TextFormField(
                        obscureText:
                            !registerController.isConfirmPasswordVisible.value,
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: UIColor.fieldColor,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: UIColor.prefixColor,
                          ),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            color: UIColor.hintColor,
                            fontSize: 12,
                          ),
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(
                            color: UIColor.hintColor,
                            fontSize: 12,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              registerController
                                  .toggleConfirmPasswordVisibility();
                            },
                            child:
                                registerController
                                    .isConfirmPasswordVisible
                                    .value
                                ? Image.asset(
                                    'images/eye.png',
                                    width: 18.33,
                                    height: 13.33,
                                  )
                                : Icon(Icons.visibility_off),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: UIColor.registerTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(text: 'By Clicking the '),
                    TextSpan(
                      text: 'Register ',
                      style: TextStyle(color: UIColor.registerColor),
                    ),
                    TextSpan(text: 'button, you agree to  the public offer'),
                  ],
                ),
              ),
              SizedBox(height: 60),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    registerController.setLoading(true);
                    await _auth
                        .createUserWithEmailAndPassword(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString(),
                        )
                        .then((value) async {
                          Utils().toastMessage('Account Created Successfully');
                          await LocalStorage.setLogin(true);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (route) => false,
                          );
                          registerController.setLoading(false);
                        })
                        .onError((error, stackTrace) {
                          final msg = error.toString();

                          if (msg.contains('email-already-in-use')) {
                            Utils().toastMessage('User already exists');
                          } else if (msg.contains('weak-password')) {
                            Utils().toastMessage('Password is too weak');
                          } else {
                            Utils().toastMessage('Something went wrong');
                          }
                          registerController.setLoading(false);
                        });
                  }
                },
                label: Obx(()=>registerController.loading.value
                    ? CircularProgressIndicator(
                        strokeWidth: 4,
                        color: Colors.white,
                      )
                    : Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: UIColor.whiteColor,
                  backgroundColor: UIColor.pinkColor,
                  minimumSize: Size(double.infinity, 50),
                  maximumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                '-Or Continue with-',
                style: TextStyle(
                  color: UIColor.loginTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: UIColor.whiteColor,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: UIColor.pinkColor),
                  boxShadow: [
                    BoxShadow(
                      color: UIColor.pinkColor.withAlpha(51),
                      spreadRadius: 7,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Image.asset('images/icon.png'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  Text(
                    'I Already Have an Account ',
                    style: TextStyle(
                      color: UIColor.loginTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await LocalStorage.setLogin(true);

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: UIColor.pinkColor,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationColor: UIColor.pinkColor,
                        // decorationThickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
