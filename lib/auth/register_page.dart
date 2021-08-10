import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:highview/doctor/doctor_home_page.dart';
import 'package:highview/utils/fire_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormBuilderState>();

  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
   String location = '';
   String speciality = '';
   String gender = '';
   String userType;

  final _focusFirstName = FocusNode();
  final _focusLastName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusFirstName.unfocus();
        _focusLastName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('HighView'),
        // ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blueGrey, Colors.lightBlueAccent]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: FormBuilder(
                key: _formKey,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Column(
                      children: <Widget>[
                        FormBuilderDropdown(
                          name: 'userType',
                          decoration: InputDecoration(
                            labelText: 'User Type',
                          ),
                          // initialValue: 'Male',
                          allowClear: true,
                          hint: Text('Select User Type'),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          items: ['Patient', 'Doctor']
                              .map((userType) => DropdownMenuItem(
                            value: userType,
                            child: Text('$userType'),
                          ))
                              .toList(),
                          onChanged: (value){
                           setState(() {
                             userType = value;
                           });
                          },
                        ),
                        SizedBox(height: 16.0),
                        FormBuilderTextField(
                          name: 'first_name',
                          controller: _firstNameTextController,
                          focusNode: _focusFirstName,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          decoration: InputDecoration(
                            hintText: "First name",
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        FormBuilderTextField(
                          name: 'last_name',
                          controller: _lastNameTextController,
                          focusNode: _focusLastName,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          decoration: InputDecoration(
                            hintText: "Last name",
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        FormBuilderTextField(
                          name: 'email',
                          controller: _emailTextController,
                          focusNode: _focusEmail,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.email(context)
                          ]),
                          decoration: InputDecoration(
                            hintText: "Email",
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        FormBuilderTextField(
                          name: 'password',
                          controller: _passwordTextController,
                          focusNode: _focusPassword,
                          obscureText: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          decoration: InputDecoration(
                            hintText: "Password",
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        FormBuilderDropdown(
                          name: 'gender',
                          decoration: InputDecoration(
                            labelText: 'Gender',
                          ),
                          // initialValue: 'Male',
                          allowClear: true,
                          hint: Text('Select Gender'),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          items: ['Male', 'Female']
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text('$gender'),
                                  ))
                              .toList(),
                          onChanged: (value){
                            gender = value.toString();
                          },
                        ),
                        SizedBox(height: 16.0),
                        userType == "Doctor" ?
                        FormBuilderDropdown(
                          name: 'speciality',
                          decoration: InputDecoration(
                            labelText: 'Doctor speciality',
                          ),
                          // initialValue: 'Male',
                          allowClear: true,
                          hint: Text('Select speciality'),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          items: [
                            'General practitioner',
                            'Gynaecologist',
                            'Psychiatrist',
                            'Dentist',
                            'General surgeon',
                            'Dermatologist',
                            'Cardiologists',
                            'Gastroenterologists',
                            'Hematologists'
                          ]
                              .map((speciality) => DropdownMenuItem(
                                    value: speciality,
                                    child: Text('$speciality'),
                                  ))
                              .toList(),
                          onChanged: (value){
                            speciality = value.toString();
                          },
                        ): Container(),
                        FormBuilderDropdown(
                          name: 'location',
                          decoration: InputDecoration(
                            labelText: 'Location',
                          ),
                          // initialValue: 'Male',
                          allowClear: true,
                          hint: Text('Select Location'),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          items: [
                            'Harare',
                            'Kwekwe',
                            'Norton',
                            'Bulawayo',
                            'Chegutu'
                          ]
                              .map((location) => DropdownMenuItem(
                                    value: location,
                                    child: Text('$location'),
                                  ))
                              .toList(),
                          onChanged: (value){
                            location = value.toString();
                          },
                        ),
                        SizedBox(height: 32.0),
                        _isProcessing
                            ? CircularProgressIndicator()
                            : Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _isProcessing = true;
                                        });
                                        _formKey.currentState?.save();
                                        if (_formKey.currentState.validate()) {
                                          User user = await FireAuth
                                              .registerUsingEmailPassword(
                                            firstName: _firstNameTextController.text,
                                            lastName: _lastNameTextController.text,
                                            email: _emailTextController.text,
                                            password:_passwordTextController.text,
                                            gender: gender,
                                            speciality: speciality,
                                            location: location,
                                            userType: userType,
                                          );

                                          setState(() {
                                            _isProcessing = false;
                                          });

                                          if (user != null) {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DoctorHome(user: user),
                                              ),
                                              ModalRoute.withName('/'),
                                            );
                                          }
                                        } else {
                                          setState(() {
                                            _isProcessing = false;
                                          });
                                          print("validation failed");
                                        }
                                      },
                                      child: Text(
                                        'Sign up',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
