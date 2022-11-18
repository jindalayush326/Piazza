import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:piazza/common/button.dart';
import 'package:piazza/common/widgets/text.dart';
import 'package:piazza/var.dart';

enum Auth {                //enum is used to restrict a value till name to a fixed set of values
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  //The framework can call this method multiple times over the lifetime of a StatefulWidget.
  // For example, if the widget is inserted into the tree in multiple locations, the framework
  // will create a separate State object for each location. Similarly, if the widget is removed
  // from the tree and later inserted into the tree again, the framework will call createState 
  //again to create a fresh State object, simplifying the lifecycle of State objects.
  State<AuthScreen> createState() => _AuthScreenState();
}
//A [FormState] object can be used to [save], [reset], and [validate] every [FormField] that 
//is a descendant of the associated [Form].
class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signin;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  //Dispose is a method triggered whenever the created object from the stateful widget
  // is removed permanently from the widget tree.
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.greyBackgroundCOlor,
      body: SafeArea(    //Creates a widget that avoids operating system interfaces.

//The [left], [top], [right], [bottom], and [minimum] arguments must not be null.


        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                tileColor: _auth== Auth.signup?Variables.backgroundColor:Variables.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                    activeColor: Variables.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      //Asynchronous programming is a technique that enables your program to
                      // start a potentially long-running task and still be able to be
                      // responsive to other events while that task runs,
                      setState(() {
                        _auth = val!;
                      });
                    }),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Variables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(controller: _nameController,
                      hintText: 'Name',),
                      const SizedBox(height: 10,),
                        CustomTextField(controller: _emailController,
                      hintText: 'E-mail',),
                       const SizedBox(height: 10,),
                        CustomTextField(controller: _passwordController,
                      hintText: 'Password',),
                      const SizedBox(height: 10,),
                      CustomButton(text: 'Sign-Up', onTap: (){})
                      ],
                    ),
                  ),
                ),
              ListTile(
                 tileColor: _auth== Auth.signin?Variables.backgroundColor:Variables.greyBackgroundCOlor,
                title: const Text(
                  'Sign-In',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                    activeColor: Variables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    }),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Variables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(controller: _emailController,
                      hintText: 'E-mail',),
                       const SizedBox(height: 10,),
                        CustomTextField(controller: _passwordController,
                      hintText: 'Password',),
                      const SizedBox(height: 10,),
                      CustomButton(text: 'Sign-In', onTap: (){})
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
