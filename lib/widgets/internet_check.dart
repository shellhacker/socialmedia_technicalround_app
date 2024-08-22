import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:socialmedia_technicalround_app/configs/theme.dart';
import 'package:socialmedia_technicalround_app/features/reels/presentation/home_screen.dart';

class InternetConnectivity extends StatelessWidget {
  const InternetConnectivity({super.key});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        connectivityBuilder: (context, connectivity, child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return child;
          } else {
            return MaterialApp(
                home: Scaffold(
                    body: Center(
                        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_outlined,
                  size: 50,
                ),
                Text(
                  "No Internet",
                  style: AppTheme.blackTextStyle,
                ),
              ],
            ))));
          }
        },
        child: HomePage());
  }
}
