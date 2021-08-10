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
            return Column(
              children: [
                Text("Full Name: ${data['firstName']} ${data['lastName']}"),
                Text("Email: ${data['email']}"),
                Text("Speciality: ${data['speciality']} "),
                Text("Location: ${data['location']} "),
                Text("Gender: ${data['gender']} "),
                Text("User Type: ${data['userType']} "),
              ],
            );
          }

          return Text("loading");
        },
      ),
    );
  }
}
