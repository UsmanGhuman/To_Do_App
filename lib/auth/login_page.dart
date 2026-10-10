import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_app/utils/color_page.dart';
import 'package:payment_app/controllers/login_controller.dart';
import 'package:payment_app/auth/forget_password.dart';
// import 'package:payment_app/home_screen.dart';
import 'package:payment_app/local_storage.dart';
import 'package:payment_app/auth/register_page.dart';
import 'package:payment_app/utils/utils.dart';
import '../main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // FIXED: Clean up controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  // bool loading = false;
  // bool isPasswordVisible = false;
  
  void login(){
    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) async{
          Utils().toastMessage('User Logged In Successfully');
          await LocalStorage.setLogin(true);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) =>  MainScreen()),
                (route) => false,
          );
         controller.setLoading(false);
    }).onError((error, stackTrace){
      Utils().toastMessage('Invalid UserId or Password');
      controller.setLoading(false);
    });
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
                  'Welcome\nBack!',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700,color: UIColor.blackColor),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      cursorColor: UIColor.hintColor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: UIColor.fieldColor,
                        prefixIcon: Icon(
                          Icons.person,
                          color: UIColor.prefixColor,
                        ),
                        labelText: 'Username or Email',
                        labelStyle: TextStyle(
                          fontSize: 12,
                          color: UIColor.hintColor,
                        ),
                        hintText: 'Username or Email',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: UIColor.hintColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: UIColor.borderColor
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: UIColor.borderColor
                            )
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Email';
                        }
                        if (!value.endsWith('@gmail.com')) {
                          return 'Use @gmail.com at the end';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Obx(()=>TextFormField(
                      obscureText: !controller.isPasswordVisible.value,
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      cursorColor: UIColor.hintColor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: UIColor.fieldColor,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: UIColor.prefixColor,
                        ),
                        suffixIcon: InkWell(
                            onTap: () {
                              controller.togglePasswordVisible();
                            },
                            child: controller.isPasswordVisible.value
                                ? Image.asset(
                              'images/eye.png',
                              width: 18.33,
                              height: 13.33,
                            )
                                : Icon(Icons.visibility_off)
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 12,
                          color: UIColor.hintColor,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: UIColor.hintColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: UIColor.borderColor
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: UIColor.borderColor
                            )
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),)
                  ],
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>ForgetPassword())
                    );
                  },
                  child: Text('Forget Password?',
                  style: TextStyle(color: UIColor.pinkColor,fontWeight: FontWeight.w400,fontSize: 12),
                ),
              ),
              ),
              SizedBox(height: 60),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    controller.setLoading(true);
                    login();
                  }
                },
                label: Obx(()=>controller.loading.value ? CircularProgressIndicator(strokeWidth: 4,color: Colors.white,) : Text(
                  'Login',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),),
                iconAlignment: IconAlignment.end,
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
              SizedBox(height: 60),
              Text(
                '-Or Continue with-',
                style: TextStyle(color: UIColor.loginTextColor,fontSize: 12,fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: UIColor.whiteColor,
                  border: Border.all(color: UIColor.pinkColor),
                  boxShadow: [
                    BoxShadow(
                      color: UIColor.pinkColor.withAlpha(51), // Shadow color
                      spreadRadius: 7, // Spread radius
                      blurRadius: 7,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.asset('images/icon.png'),
              ),
              SizedBox(height: 20),
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create An Account',
                    style: TextStyle(color: UIColor.loginTextColor,fontSize: 14,fontWeight: FontWeight.w400),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>RegisterPage())
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: UIColor.pinkColor,
                        decoration: TextDecoration.underline,
                        decorationColor: UIColor.pinkColor,
                        // decorationThickness: 0,
                        decorationStyle: TextDecorationStyle.solid,
                        fontWeight: FontWeight.w600,
                        fontSize: 14
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
//1111+200+650