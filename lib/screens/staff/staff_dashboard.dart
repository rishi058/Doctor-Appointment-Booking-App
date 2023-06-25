import 'package:clinic/Widgets/dashboard_box.dart';
import 'package:clinic/shared/typography.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../shared/drawer.dart';

class StaffDashboard extends StatefulWidget {
  const StaffDashboard({Key? key}) : super(key: key);

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? mtoken = '';

  @override
  void initState() {
    // addData();
    super.initState();
    requestPermission();
    getToken();
    initInfo();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // print('User Permission Granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // print('User granted provisional permission.');
    } else {
      // print('User permission not granted.');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        if (kDebugMode) {
          print('My token is (staff) $mtoken');
        }
      });
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection('StaffTokens')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'token': token});
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationsSettings = InitializationSettings(
      android: androidInitialize,
    );
    FlutterLocalNotificationsPlugin().initialize(initializationsSettings,
        onSelectNotification: (String? payload) async {
      // print('&&&');
      // print(payload);
      try {
        if (payload != null && payload.isNotEmpty) {
          // print('Ready to navigate...');
        }
      } catch (e) {
        // print('error');
        // print(e.toString());
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
      // print('**************');
      // print(
      //     'onMessage: ${remoteMessage.notification?.title} / ${remoteMessage.notification?.body}');
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        remoteMessage.notification!.body.toString(),
        htmlFormatTitle: true,
        contentTitle: remoteMessage.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'dbfood',
        'dbfood',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );
      await FlutterLocalNotificationsPlugin().show(
          0,
          remoteMessage.notification?.title,
          remoteMessage.notification?.body,
          platformChannelSpecifics,
          payload: remoteMessage.data['body']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: const MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Image.asset(
                'assets/menu.png',
                scale: 1.6,
              )),
          actions: [
            Image.asset(
              'assets/profileIcon.png',
              scale: 1.6,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 40.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Container(
                  margin: EdgeInsets.only(top: 7.5.h, left: 10.w),
                  child: Text(
                    'Physiotherapist Dashboard',
                    style: theme(),
                  ),
                ),
              ), //....................................................................................................................................................
              Container(
                  margin: EdgeInsets.only(
                    top: 30.h,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('assigned-task');
                            },
                            child: box('Assigned Appointment', 'assets/11.png'),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('completed-task');
                              },
                              child: box(
                                  'Completed Appointments', 'assets/22.png')),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('update-staff-profile');
                              },
                              child: box('Update Profile', 'assets/44.png')),
                          Container(
                            height: 240.h,
                            width: 155.w,
                            margin: EdgeInsets.all(10.h),
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ));
  }
}
