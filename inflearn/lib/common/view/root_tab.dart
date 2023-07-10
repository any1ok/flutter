import 'package:flutter/material.dart';
import 'package:inflearn/common/const/colors.dart';
import 'package:inflearn/common/const/default_layout.dart';
import 'package:inflearn/user/view/profile_screen.dart';

import '../../product/view/product_screen.dart';
import '../../restaurant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin{
  late TabController controller;

  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 5, vsync: this);
    controller.addListener(tabListner);
  }

  void tabListner(){
    setState(() {
      index = controller.index;
    });
  }

  @override
  void dispose() {
    controller.removeListener(tabListner);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'my-tasty',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          RestaurantScreen(),
          ProductScreen(),
          Center(child: Container(child: Text('리스트'))),
          Center(child: Container(child: Text('친구'))),
          ProfileScreen(),
        ],
      ),
      BottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type:  BottomNavigationBarType.fixed,
        onTap: (int index){
          controller.animateTo(index);

        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '식당',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: '리스트',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '친구',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: '설정',
          ),
        ],
      ),
    );
  }
}
