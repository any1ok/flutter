import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inflearn/user/provider/auth_provider.dart';

final routerProivder = Provider<GoRouter>((ref) {
  final provider = ref.read(authProivder);
  
  return GoRouter(
      routes: provider.routes,
      initialLocation:  '/splash',
      refreshListenable: provider,
      redirect: provider.redirectLogic,
  );
});