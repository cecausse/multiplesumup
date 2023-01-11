import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multiplesumup/screens/home_screen.dart';
import 'package:multiplesumup/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        title: 'Multiple Sumup',
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
        });
  }
}
