  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:payment_app/utils/color_page.dart';
  import 'package:payment_app/utils/utils.dart';
  import '../local_storage.dart';
  import '../auth/login_page.dart';


  class ProfilePage extends StatefulWidget {
    const ProfilePage({super.key});

    @override
    State<ProfilePage> createState() => _ProfilePageState();
  }

  class _ProfilePageState extends State<ProfilePage> {
    final auth = FirebaseAuth.instance;
    final User? user = FirebaseAuth.instance.currentUser;

    @override
    Widget build(BuildContext context) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop,result){
          if(!didPop){
            // Navigator.pop(context);
          }
        },
        child: Scaffold(
          // bottomNavigationBar: CustomBottomNavBar(parentContext: context),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Column(
                    children: [
                      Text('Profile', style: TextStyle(color: UIColor.profilePageTextColor,fontSize: 20,fontWeight: FontWeight.w400)),
                      SizedBox(height: 15),
                      CircleAvatar(
                        radius: 40,
                        child: Image.asset('images/img10.png'),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 32),
                        child: Row(
                          spacing: 20,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 30,
                                ),
                                decoration: BoxDecoration(
                                  color: UIColor.pinkColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    '10 Tasks Left',
                                    style: TextStyle(color: UIColor.whiteColor),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 30,
                                ),
                                decoration: BoxDecoration(
                                  color: UIColor.pinkColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    '5 Tasks Done',
                                    style: TextStyle(color: UIColor.whiteColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 10),
                      newMethod(text: 'Settings'),
                      // SizedBox(height: 10),
                      tilesListTile(
                        leading: Icons.settings,
                        title: 'App Setting',
                        trailing: Icons.arrow_forward_ios,
                      ),
                      newMethod(text: 'Account'),
                      tilesListTile(
                        leading: Icons.person_outline_sharp,
                        title: 'Change account name',
                        trailing: Icons.arrow_forward_ios,
                      ),
                      tilesListTile(
                        leading: Icons.vpn_key_outlined,
                        title: 'Change account password',
                        trailing: Icons.arrow_forward_ios,
                      ),
                      tilesListTile(
                        leading: Icons.camera_alt_sharp,
                        title: 'Change account Image',
                        trailing: Icons.arrow_forward_ios,
                      ),
                      newMethod(text: 'UpTodo'),
                      tilesListTile(
                        leading: Icons.grid_view,
                        title: 'Abouts Us',
                        trailing: Icons.arrow_forward_ios,
                      ),
                      tilesListTile(
                        leading: Icons.error_outline,
                        title: 'FAQ',
                        trailing: Icons.arrow_forward_ios,
                      ),tilesListTile(
                        leading: Icons.bolt,
                        title: 'Help & Feedback',
                        trailing: Icons.arrow_forward_ios,
                      ),tilesListTile(
                        leading: Icons.thumb_up,
                        title: 'Support Us',
                        trailing: Icons.arrow_forward_ios,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,top: 10),
                        child: InkWell(
                          onTap: () async{
                            auth.signOut().then((value) async{
                            await LocalStorage.setLogin(false);
                              Utils().toastMessage('Logout Successful');
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                                  (route) => false,
                            );
                            }).onError((error, stackTrace){
                              Utils().toastMessage(error.toString());
                            });
                          },
                          child: Row(
                            spacing: 10,
                            children: [
                              Image.asset('images/logout.png',width: 25,),
                              Text('Log out',style: TextStyle(color: UIColor.pinkColor,fontSize: 16),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 70,)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Padding newMethod({required String text}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24,),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(text, style: TextStyle(color: UIColor.greyColor,fontWeight: FontWeight.w400,fontSize: 14)),
        ),
      );
    }

    ListTile tilesListTile({
      required IconData leading,
      required String title,
      required IconData trailing,
    }) {
      return ListTile(
        leading: Icon(leading),
        title: Text(title),
        trailing: Icon(trailing,size: 15,),
      );
    }
  }


