// import 'package:flutter/material.dart';
//
// class DefaultLayout extends StatelessWidget {
//   final Widget child;
//
//   const DefaultLayout({
//     required this.child,
//     Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(child: child),
//     );
//   }
// }

import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? title;
  final Widget? BottomNavigationBar;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.BottomNavigationBar,
  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppbar(),
      body: child,
      bottomNavigationBar: BottomNavigationBar,
    );
  }

  AppBar? renderAppbar() {
    if(title == null){
      return null;
    }else{
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        // app 바 위의 위젯
        foregroundColor: Colors.black,
      );
    }

  }
}
