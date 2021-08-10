import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({Key key, this.docDetails}) : super(key: key);

  final DocumentSnapshot docDetails;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = docDetails.data() as Map<String, dynamic>;
    CollectionReference appointments =
        FirebaseFirestore.instance.collection('appointments');
    final FirebaseAuth _ath = FirebaseAuth.instance;
    DateTime bookingDate;
    String additionalInfo;
    Future<void> addAppointment() {
      return appointments
          .add({
            'fullName': '${data['firstName']} ${data['lastName']}',
            'bookingDate': bookingDate,
            'additionalInfo': additionalInfo,
            'doctorId': data['userUid'],
            'patientId': _ath.currentUser.uid,
            'dateCreated': DateTime.now(),
            'status': 'New'
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor details"),
      ),
      body: SingleChildScrollView(
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
                        maxTime: DateTime(2023, 6, 7), onChanged: (date) {
                      bookingDate = date;
                    },
                        onConfirm: (date) {},
                        currentTime: DateTime.now(),
                        locale: LocaleType.en);
                  },
                  child: Text(
                    'Select booking date and time',
                  ),
                ),
                // _displayData('Date booked for',"$bookingDate"),
                TextField(
                  decoration: const InputDecoration(
                      icon: Icon(Icons.note),
                      hintText:
                          'any information that you would want to notify the doctor',
                      labelText: 'Additional Info',
                      hintMaxLines: 3),
                  onChanged: (String value) {
                    additionalInfo = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    addAppointment();
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
