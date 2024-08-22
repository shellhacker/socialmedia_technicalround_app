import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia_technicalround_app/injection_container.dart';
import 'package:socialmedia_technicalround_app/widgets/internet_check.dart';

import '../../reels/application/bloc/reels_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) =>
                        ReelsBloc(getReelsCollectionUsecase: sl()),
                    child: InternetConnectivity(),
                  )),
        );
      });
    });

    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Icon(
          Icons.ac_unit_rounded,
          size: 60,
        ), // Your splash image
      ),
    );
  }
}
