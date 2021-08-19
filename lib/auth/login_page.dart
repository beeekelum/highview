import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:highview/auth/profile_page.dart';
import 'package:highview/auth/register_page.dart';
import 'package:highview/doctor/doctor_home_page.dart';
import 'package:highview/utils/fire_auth.dart';
import 'package:highview/utils/validator.dart';
import 'package:highview/widget/first.dart';
import 'package:highview/widget/textLogin.dart';
import 'package:highview/widget/verticalText.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DoctorHome(
            user: user,
          ),
        ),
      );
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Login'),
                Tab(text: 'Register'),

              ],
            ),
            title: const Text('Highview'),
            elevation: 0,
          ),
          body:  TabBarView(
            children: [
              loginForm(),
              RegisterPage(),
            ],
          ),
        ),
      ),
    );

  }

  GestureDetector loginForm(){
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                child: Form(
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.blueGrey, Colors.lightBlueAccent]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(children: <Widget>[
                                VerticalText(),
                                TextLogin(),
                              ]),
                              SizedBox(height: 25.0),
                              inputEmail(),
                              SizedBox(height: 25.0),
                              passwordInput(),
                              SizedBox(height: 30.0),
                              _isProcessing
                                  ? CircularProgressIndicator()
                                  : buttonLogin(),
                              // FirstTime(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  TextFormField inputEmail() {
    return TextFormField(
      controller: _emailTextController,
      focusNode: _focusEmail,
      validator: (value) => Validator.validateEmail(
        email: value,
      ),
      decoration: InputDecoration(
        hintText: "Email",
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  TextFormField passwordInput() {
    return TextFormField(
      controller: _passwordTextController,
      focusNode: _focusPassword,
      obscureText: true,
      validator: (value) => Validator.validatePassword(
        password: value,
      ),
      decoration: InputDecoration(
        hintText: "Password",
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Row buttonLogin() {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              _focusEmail.unfocus();
              _focusPassword.unfocus();

              if (_formKey.currentState
                  .validate()) {
                setState(() {
                  _isProcessing = true;
                });

                User user = await FireAuth
                    .signInUsingEmailPassword(
                    email: _emailTextController.text,
                    password:
                    _passwordTextController.text,
                    context: context
                );

                setState(() {
                  _isProcessing = false;
                });

                if (user != null) {
                  Navigator.of(context)
                      .pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          DoctorHome(user: user),
                    ),
                  );
                }
              }
            },
            child: Text(
              'Sign In',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),

      ],
    );
  }
}