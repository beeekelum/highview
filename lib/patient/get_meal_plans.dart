import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MealPlan extends StatelessWidget {
  const MealPlan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('mealPlans').where("patientId", isEqualTo: _auth.currentUser.uid).snapshots();
    return Scaffold(
        appBar: AppBar(
          title: Text("My Diet plan"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text('${data['day']}'),
                  subtitle: Text(data['mealType']),
                  leading: CircleAvatar(child: Icon(Icons.set_meal),),
                  trailing: TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DoctorDetails(docDetails: document,),
                      //   ),);
                    },
                    child: Text("View"),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}
