import 'dart:developer';
// import 'package:flutter/services';
import 'package:flutter/material.dart';
import 'package:piazza/features/auth/screens/auth_screen.dart';
import 'package:piazza/route.dart';
import 'package:piazza/var.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Piazza',
        theme: ThemeData(
          scaffoldBackgroundColor: Variables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: Variables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              )),
        ),
        onGenerateRoute: ((settings) => generateRoute(settings)),
        home: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              log(snapshot.data.toString());
              if (snapshot.hasError) {
                print('You have an error! ${snapshot.error.toString()}');
                return Text('Something went wrong!');
              } else if (snapshot.hasData) {
                return const AuthScreen();
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })

        // home: Scaffold(
        //   appBar: AppBar(
        //     title: const Text('Piazza'),
        //   ),
        //   body: Column(
        //     children: [
        //       const Center(
        //         child: Text('Application Home Page'),
        //       ),
        //       Builder(
        //         builder: (context) {
        //           return ElevatedButton(
        //             onPressed: () {
        //               Navigator.pushNamed(
        //                 context, AuthScreen.routeName
        //               );
        //             },
        //             child: Text('Click'),
        //           );
        //         }
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
