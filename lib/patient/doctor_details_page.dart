import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({Key key, this.docDetails}) : super(key: key);

  final DocumentSnapshot docDetails;

  @override
  Widget build(BuildContext context) {
    String patientName, email, phoneNumber;
    Map<String, dynamic> data = docDetails.data() as Map<String, dynamic>;
    CollectionReference appointments =
        FirebaseFirestore.instance.collection('appointments');
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        patientName = '${data['firstName']} ${data['lastName']}';
        email = '${data['email']}';
        phoneNumber = '${data['phoneNumber']}';
        print('Document exists on the database');
      }
    });
    DateTime bookingDate;
    String additionalInfo;
    Future<void> addAppointment() {
      return appointments
          .add({
            'fullName': patientName,
            'email': email,
            'phoneNumber': phoneNumber,
            'bookingDate': bookingDate,
            'additionalInfo': additionalInfo,
            'doctorId': data['userUid'],
            'patientId': _auth.currentUser.uid,
            'dateCreated': DateTime.now(),
            'status': 'New'
          })
          .then((value) => Get.snackbar('HighView', 'Booking successfully', backgroundColor: Colors.green))
          .catchError((error) => print("Failed to add user: $error"));
    }

    final _formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor details"),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Center(
            child: Container(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person),
                  ),
                  _displayData('First name', data['firstName']),
                  _displayData('Last name', data['lastName']),
                  _displayData('Email', data['email']),
                  _displayData('Gender', data['gender']),
                  _displayData('Location', data['location']),
                  _displayData('Speciality', data['speciality'] ?? ""),
                  _displayData('User type', data['userType']),
                  // _displayData('',data['userUid']),
                  TextButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(2022, 6, 7), onChanged: (date) {
                        bookingDate = date;
                      },
                          onConfirm: (date) {},
                          currentTime: DateTime.now(),
                          locale: LocaleType.en);
                    },
                    child: Text(
                      'Select booking date and time',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // _displayData('Date booked for',"$bookingDate"),
                  TextField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.note),
                        hintText:
                            'any information that you would want to notify the doctor',
                        labelText: 'Additional Info',
                        hintMaxLines: 5),
                    onChanged: (String value) {
                      additionalInfo = value;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print(bookingDate);
                      if (bookingDate == null) {
                        Get.snackbar(
                          'Warning',
                          'Please select booking date',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red
                        );
                      } else {
                        addAppointment();
                      }
                    },
                    child: Text(
                      'Book doctor',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _displayData(String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(key),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
