import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
        appBar: AppBar(
           title: const Text('Profile'),
         ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(user.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data.exists) {
            return Text("Document does not exist ${user.uid}");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
            return Center(
              child: Column(
                children: [
                  CircleAvatar(radius: 50, child: Icon(Icons.person),),
                  _displayData("Full Name:", "${data['firstName']} ${data['lastName']}"),
                  _displayData("Email:", "${data['email']}"),
                  data['userType'] == 'Doctor' ? _displayData("Speciality:", "${data['speciality']} "): Container(),
                  _displayData("Location:", "${data['location']} "),
                  _displayData("Gender:", "${data['gender']} "),
                  _displayData("User Type:", "${data['userType']} "),
                ],
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
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
