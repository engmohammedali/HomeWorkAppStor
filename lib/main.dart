import 'package:appstore/firebase_options.dart';
import 'package:appstore/pages/cart/Mybasket.dart';
import 'package:appstore/pages/home/home_page.dart';

import 'package:appstore/pages/shared/models/Provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Model(),
      child: MaterialApp(
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        // home: StreamBuilder(
        //     stream: FirebaseAuth.instance.authStateChanges(),
        //     builder: ((context, snapshot) {
        //       if (snapshot.hasData) {
        //         return HomePage();
        //       } else {
        //         return Login();
        //       }
        //     })),
      ),
    );
  }
}
