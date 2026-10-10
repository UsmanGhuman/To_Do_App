import 'package:payment_app/home/app_model.dart';
import 'package:payment_app/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../utils/color_page.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/local_storage.dart';
import 'package:payment_app/auth/login_page.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void myDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Card();
      },
    );
  }

  List<String> elements = ['All', 'To-do', 'In Progress', 'Continue', 'Done'];
  List<int> dates = List.generate(30, (i) => i + 1);
 static  List<String> baseWeekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  List<String> weekDays = List.generate(
    30,
        (i) => baseWeekDays[i % 7],
  );
  int currentIndex = 0;
  int currentIndexElement = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: CustomBottomNavBar(parentContext: context),
      appBar: AppBar(
        backgroundColor: UIColor.whiteColor,
        // elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'Today\'s Tasks !',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
        ),
        actions: [
          //  LOGOUT BUTTON
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () async {
              await LocalStorage.setLogin(false);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
        //  RESET BUTTON
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () async {
            await LocalStorage.setLogin(false);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/emg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      itemCount: 30,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                margin: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 10,
                                ),
                                height: 86,
                                width: 64,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? UIColor.redColor
                                      : UIColor.whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: currentIndex == index
                                          ? UIColor.redColor
                                          : UIColor.blackColor.withAlpha(51),
                                      blurRadius: 15,
                                      // spreadRadius: 2
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'May',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: currentIndex == index
                                            ? UIColor.whiteColor
                                            : UIColor.blackColor,
                                      ),
                                    ),
                                    Text(
                                      dates[index].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19,
                                        color: currentIndex == index
                                            ? UIColor.whiteColor
                                            : UIColor.blackColor,
                                      ),
                                    ),
                                    Text(
                                      weekDays[index],
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: currentIndex == index
                                            ? UIColor.whiteColor
                                            : UIColor.blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndexElement = index;
                            });
                          },
                          child: Row(
                            // spacing: 12,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                margin: EdgeInsets.only(left: 24, right: 10),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  // vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: currentIndexElement == index
                                      ? UIColor.redColor
                                      : UIColor.whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: currentIndexElement == index
                                          ? UIColor.redColor
                                          : UIColor.blackColor.withAlpha(51),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    elements[index],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: currentIndexElement == index
                                          ? UIColor.whiteColor
                                          : UIColor.blackColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: Boxes.getData().listenable(),
                    builder: (context, box, _) {
                      var allData = box.values.toList().cast<AppModel>();

                      String selectedFilter = elements[currentIndexElement];

                      var data = selectedFilter == 'All'
                          ? allData
                          : allData
                                .where((e) => e.status == selectedFilter)
                                .toList();

                      return data.isEmpty
                          ? Column(
                              children: [
                                Image.asset('images/img9.png', width: 200),
                                Text(
                                  'No Todo Found!\nPlease Create One',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: UIColor.blackColor.withAlpha(101),
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 10,
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        // 🔹 Top Row
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data[index].title,
                                              style: TextStyle(
                                                color: UIColor.secondaryColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  style: IconButton.styleFrom(
                                                    // backgroundColor: Colors.red,
                                                    minimumSize: Size(0, 0),
                                                    padding: EdgeInsets.all(2),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    // maximumSize: Size(0,0),
                                                  ),
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () {
                                                    delete(data[index]);
                                                  },
                                                ),
                                                IconButton(
                                                  style: IconButton.styleFrom(
                                                    // backgroundColor: Colors.red,
                                                    minimumSize: Size(0, 0),
                                                    padding: EdgeInsets.all(2),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                  ),
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () {
                                                    edit(data[index]);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        // 🔹 Description
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                data[index].description,
                                                style: TextStyle(
                                                  color: UIColor.blackHomeColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 🔹 Bottom Row
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // time (static for now)
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'images/timecircle.png',
                                                ),
                                                Text(
                                                  '09:00 PM',
                                                  style: TextStyle(
                                                    color:
                                                        UIColor.pinkHomeColor,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            // 🔹 Status
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                              ),
                                              height: 25,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: UIColor.homeDoneColor,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  data[index].status,
                                                  style: TextStyle(
                                                    color: UIColor.todoColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton:
    );
  }

  void delete(AppModel appModel) async {
    await appModel.delete();
  }

  void edit(AppModel appModel) {
    TextEditingController titleController = TextEditingController(
      text: appModel.title,
    );

    TextEditingController descriptionController = TextEditingController(
      text: appModel.description,
    );
    TextEditingController statusController = TextEditingController(
      text: appModel.status,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Edit Task',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),

                SizedBox(height: 10),

                TextField(
                  controller: titleController,
                  cursorColor: UIColor.blackColor,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 10),

                TextField(
                  controller: descriptionController,
                  cursorColor: UIColor.blackColor,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: statusController,
                  cursorColor: UIColor.blackColor,
                  decoration: InputDecoration(
                    hintText: 'Status',
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 15),

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      appModel.title = titleController.text;
                      appModel.description = descriptionController.text;
                      appModel.status = statusController.text;

                      appModel.save();

                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.cancel,
                            size: 25,
                            color: UIColor.pinkColor,
                          ),
                        ),
                        Image.asset('images/send.png', width: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

