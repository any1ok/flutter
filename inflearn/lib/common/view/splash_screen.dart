import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn/common/const/data.dart';
import 'package:inflearn/common/const/default_layout.dart';
import 'package:inflearn/common/secure_storage/secure_storage.dart';
import 'package:inflearn/common/view/root_tab.dart';
import 'package:inflearn/user/view/login_screen.dart';

import '../const/colors.dart';



class SplashScreen extends ConsumerWidget {
  static String get routeName => 'splash';


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/logo/my-tasty.png',
              width: MediaQuery.of(context).size.width/2,
            ),
            const SizedBox(height: 16.0,),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
