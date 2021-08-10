import 'package:get/get.dart';
import 'package:highview/auth/login_page.dart';
import 'package:highview/patient/doctor_list.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(
      name: "/doctor_list/:speciality_name/view",
      page: () => DoctorList(),
    ),

  ];
}
