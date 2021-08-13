import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentDetails extends StatelessWidget {
  const AppointmentDetails({Key key, this.appointmentDetails})
      : super(key: key);

  final DocumentSnapshot appointmentDetails;

  @override
  Widget build(BuildContext context) {
    String results;
    Map<String, dynamic> data = appointmentDetails.data() as Map<String, dynamic>;
    CollectionReference appointments =
    FirebaseFirestore.instance.collection('appointments');

    Future<void> addAppointmentResults() {
      return appointments.doc(appointmentDetails.id)
          .update({
        'results': results,
        'status': 'Completed'
      })
          .then((value) => Get.snackbar('HighView', 'Results updated successfully'))
          .catchError((error) => print("Failed to add user: $error"));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Details"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Container(
            child: Column(
              children: [
                _displayData('Patient Name', data['fullName']),
                _displayData('Booking Date', (data["bookingDate"] as Timestamp)
                    .toDate()
                    .toString()),
                _displayData('Additional Info', data['additionalInfo']),
                _displayData('Status', data['status']),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      maxLines: 7,

                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                        icon: Icon(Icons.note),
                        hintText:
                        'Findings, Results and or prescriptions',
                        labelText: 'Appointment results',

                    ),
                    onChanged: (String value) {
                      results = value;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    addAppointmentResults();
                  },
                  child: Text(
                    'Submit',
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
