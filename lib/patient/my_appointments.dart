import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({Key key}) : super(key: key);

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('My Appointments'),
      // ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'New and Pending'),
                Tab(text: 'Completed'),
              ],
            ),
            title: const Text('My Appointments'),
          ),
          body: const TabBarView(
            children: [
              NewAppointments(),
              CompletedAppointments(),
            ],
          ),
        ),
      ),
    );
  }
}

class NewAppointments extends StatelessWidget {
  const NewAppointments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _appointmentsStream =
    FirebaseFirestore.instance.collection('appointments')
        .where('patientId', isEqualTo: _auth.currentUser.uid)
        .where('status', isEqualTo: 'Pending')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _appointmentsStream,
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('${data['fullName']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((data["bookingDate"] as Timestamp).toDate().toString()),
                      Text(data['status']),
                    ],
                  ),
                  leading: CircleAvatar(child: Icon(Icons.person),),
                  trailing: TextButton.icon(
                    onPressed: () {
                    },
                    label: Text("View"),
                    icon: Icon(Icons.search),
                  ),
                ),
                Row(
                  children: [
                    TextButton.icon(onPressed: (){}, icon: Icon(Icons.done), label: Text('Accept')),
                    TextButton.icon(onPressed: (){}, icon: Icon(Icons.cancel), label: Text('Decline')),
                  ],
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}

class CompletedAppointments extends StatelessWidget {
  const CompletedAppointments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


