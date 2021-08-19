import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class MealExercisePlan extends StatefulWidget {
  const MealExercisePlan({Key key, this.patientDetails}) : super(key: key);
  final DocumentSnapshot patientDetails;

  @override
  _MealExercisePlanState createState() => _MealExercisePlanState();
}

class _MealExercisePlanState extends State<MealExercisePlan> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    String day, mealType, description;
    CollectionReference mealPlans =
        FirebaseFirestore.instance.collection('mealPlans');
    final FirebaseAuth _auth = FirebaseAuth.instance;
    Map<String, dynamic> data =
        widget.patientDetails.data() as Map<String, dynamic>;

    Future<void> addMealPlan() {
      return mealPlans
          .add({
            'day': day,
            'mealType': mealType,
            'description': description,
            'patientId': data['userUid'],
            'doctorId': _auth.currentUser.uid,
            'dateCreated': DateTime.now(),
          })
          .then((value) => Get.snackbar('HighView', 'Meal plan for patient'))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Meal and Exercise plan"),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Container(
            child: Column(children: [
              _displayData('Patient name', data['fullName']),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FormBuilderDropdown(
                  name: 'day',
                  decoration: InputDecoration(
                    labelText: 'Gender',
                  ),
                  // initialValue: 'Male',
                  allowClear: true,
                  hint: Text('Select Day'),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)]),
                  items: [
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday'
                  ]
                      .map((day) => DropdownMenuItem(
                            value: day,
                            child: Text('$day'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    day = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FormBuilderDropdown(
                  name: 'meal',
                  decoration: InputDecoration(
                    labelText: 'Meal Type',
                  ),
                  // initialValue: 'Male',
                  allowClear: true,
                  hint: Text('Select meal type'),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)]),
                  items: ['Breakfast', 'Lunch', 'Dinner', 'Snack']
                      .map((mealType) => DropdownMenuItem(
                            value: mealType,
                            child: Text('$mealType'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    mealType = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FormBuilderTextField(
                  name: 'description',
                  decoration: InputDecoration(
                    labelText: 'Meal plan',
                  ),
                  onChanged: (value) {
                    description = value;
                  },
                  // valueTransformer: (text) => num.tryParse(text),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        color: Theme.of(context).accentColor,
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          addMealPlan();
                          _formKey.currentState.save();
                          if (_formKey.currentState.validate()) {
                            print(_formKey.currentState.value);
                          } else {
                            print("validation failed");
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: MaterialButton(
                        color: Theme.of(context).accentColor,
                        child: Text(
                          "Reset",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          _formKey.currentState.reset();
                        },
                      ),
                    )
                  ],
                ),
              )
            ]),
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
