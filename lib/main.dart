import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:socialmedia_technicalround_app/configs/theme.dart';

import 'features/Authentication/presentation/splash_screen.dart';
import 'injection_container.dart';

void main() {
  init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()

        //  HomePage(),
        );
  }
}
