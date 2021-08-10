import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highview/patient/doctor_details_page.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('users').where("userType", isEqualTo: "Doctor").snapshots();
    return Scaffold(
        appBar: AppBar(
          title: Text("Doctors"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text('${data['firstName']} ${data['lastName'] }'),
                  subtitle: Text(data['userType']),
                  leading: CircleAvatar(child: Icon(Icons.person),),
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorDetails(docDetails: document,),
                        ),);
                    },
                    child: Text("Book"),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}
