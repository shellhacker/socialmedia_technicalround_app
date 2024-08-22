import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia_technicalround_app/features/reels/presentation/home_screen.dart';
import 'package:socialmedia_technicalround_app/injection_container.dart';

import '../../reels/application/bloc/reels_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) =>
                        ReelsBloc(getReelsCollectionUsecase: sl()),
                    child: HomePage(),
                  )),
        );
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Icon(
          Icons.ac_unit_rounded,
          size: 30,
        ), // Your splash image
      ),
    );
  }
}
