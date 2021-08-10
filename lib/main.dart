import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highview/auth/login_page.dart';
import 'package:highview/doctor/symptom_checker.dart';
import 'package:highview/get_routes.dart';
import 'package:highview/utils/fire_auth.dart';
import 'package:provider/provider.dart';

import 'models/user_obj.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
            value: FirebaseAuth.instance.authStateChanges()),
      ],
      child:
          GetMaterialApp(
        title: 'HighView',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        initialRoute: '/login',
        // home: LoginPage(),
            getPages: AppRoutes.routes,
      ),
    );
    // );
  }
}
