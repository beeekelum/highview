import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highview/auth/profile_page.dart';
import 'package:highview/doctor/doc_dashboard.dart';
import 'package:highview/doctor/doctor_appointments.dart';
import 'package:highview/doctor/profile.dart';
import 'package:highview/doctor/my_patients.dart';
import 'package:highview/doctor/symptom_checker.dart';
import 'package:highview/patient/doctor_type_list.dart';
import 'package:highview/patient/my_appointments.dart';
import 'package:highview/patient/my_diagnosis.dart';
import 'package:highview/patient/my_medical_information.dart';
import 'package:highview/patient/my_visits.dart';

/// This is the main application widget.
class DoctorHome extends StatefulWidget {
  final User user;

  const DoctorHome({Key key, this.user}) : super(key: key);

  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  User user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(user.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data.exists) {
            return Text("User does not exist ${user.uid}");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data.data() as Map<String, dynamic>;
            return MyStatefulWidget(data: data,);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      // body: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  final Map<String, dynamic> data;

   MyStatefulWidget({Key key, this.data}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  List<Widget> _doctorWidgetOptions = <Widget>[
    DoctorDashboard(),
    DoctorAppointments(),
    MyPatients(),
    Profile(),
  ];

  List<Widget> _patientWidgetOptions = <Widget>[
    MyHome(),
    DoctorTypeList(),
    MyAppointments(),
    SymptomChecker(),
    MyMedicalInformation(),
    Profile(),
  ];

  List<BottomNavigationBarItem> _doctorWidgetIcons = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      label: 'Appointments',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sick),
      label: 'My Patients',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: 'Profile',
    ),
  ];

  List<BottomNavigationBarItem> _patientsWidgetIcons = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.description),
      label: 'Book Doctor',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      label: 'Appointments',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.thermostat_outlined),
      label: 'Symptom checker',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: 'Profile',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widget.data["userType"] == "Doctor" ? _doctorWidgetOptions.elementAt(_selectedIndex) : _patientWidgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: widget.data["userType"] == "Doctor" ? _doctorWidgetIcons : _patientsWidgetIcons,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        backgroundColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
