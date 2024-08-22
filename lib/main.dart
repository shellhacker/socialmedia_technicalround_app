import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'features/Authentication/presentation/splash_screen.dart';
import 'features/reels/application/bloc/reels_bloc.dart';
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
    return OfflineBuilder(
      connectivityBuilder: (context, connectivity, child) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return MaterialApp(
              debugShowCheckedModeBanner: false, home: SplashScreen()

              //  HomePage(),
              );
        } else {
          return MaterialApp(home: Scaffold(body: Text("data")));
        }
      },
      child: Text('dswrfgegrrf'),
    );
  }
}
