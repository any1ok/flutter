import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inflearn/common/view/root_tab.dart';
import 'package:inflearn/common/view/splash_screen.dart';
import 'package:inflearn/restaurant/view/restaurant_detail_screen.dart';
import 'package:inflearn/user/model/user_model.dart';
import 'package:inflearn/user/provider/user_me_provider.dart';
import 'package:inflearn/user/view/login_screen.dart';

final authProivder = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref :ref);
});

class AuthProvider extends ChangeNotifier{
  final Ref ref;

  AuthProvider({
    required this.ref
}){
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if(previous != next){
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
    GoRoute(
      path: '/',
      name: RootTab.routeName,
      builder: (_,__) => RootTab(),
      routes: [
        GoRoute(
          path: 'restaurant/:rid',
          builder: (_,state) => RestaurantDetailScreen(id: state.pathParameters['rid']!),
        ),
      ]
    ),
      GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_,__) => SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.routeName,
        builder: (_,__) => LoginScreen(),
      ),
  ];


  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state ){
    final UserModelBase? user = ref.read(userMeProvider);

    final logginIn = state.location == '/login';

    if(user == null){
      return logginIn ? null : '/login';
    }

    if(user is UserModel){
      return logginIn || state.location == '/splash' ? '/' : null;
    }

    if(user is UserModelError){
      return  !logginIn ? '/login' : null;
    }

    return null;
  }
}