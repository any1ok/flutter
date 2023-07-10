import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn/common/component/custom_text_form_field.dart';
import 'package:inflearn/common/provider/go_router.dart';
import 'package:inflearn/common/view/splash_screen.dart';
import 'package:inflearn/user/provider/auth_provider.dart';
import 'package:inflearn/user/view/login_screen.dart';

void main() {
  runApp(
      ProviderScope(
        child:  _App(),
      )
  );
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProivder);
    return MaterialApp.router(
      theme: ThemeData(
          fontFamily: 'NotoSans'
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}


