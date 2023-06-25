// ignore_for_file: unused_element

import 'package:clinic/models/appointment_model.dart';
import 'package:clinic/models/feedback_model.dart';
import 'package:clinic/models/patient_model.dart';
import 'package:clinic/models/staff_model.dart';
import 'package:clinic/provider/patient_provider.dart';
import 'package:clinic/provider/staff_provider.dart';
import 'package:clinic/screens/intro_screens/splash_screen.dart';
import 'package:clinic/services/database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'all_pages.dart';

Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  if (kDebugMode) {
    // print('Handling a background message ${remoteMessage.messageId}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => PatientProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => StaffProvider(),
              ),
              StreamProvider<List<AppointmentModel>>.value(
                value: Database().allAppointments,
                initialData: const [],
              ),
              StreamProvider<List<PatientModel>>.value(
                value: Database().allPatients,
                initialData: const [],
              ),
              StreamProvider<List<StaffModel>>.value(
                value: Database().allStaff,
                initialData: const [],
              ),
              StreamProvider<List<FeedBackModel>>.value(
                value: Database().feedback,
                initialData: const [],
              ),
            ],
            child: MaterialApp(
                home: const SplashScreen(),
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.deepPurple,
                  scaffoldBackgroundColor:
                      const Color.fromRGBO(236, 241, 250, 1),
                  pageTransitionsTheme: const PageTransitionsTheme(
                    builders: {
                      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    },
                  ),
                ),
                routes: getPages),
          );
        });
  }
}
