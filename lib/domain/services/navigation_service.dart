import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_uz/data/model/user.dart';
import 'package:split_uz/presentation/auth/otp_page.dart';
import 'package:split_uz/presentation/auth/phone_number_page.dart';
import 'package:split_uz/presentation/creating_profile.dart/creating_profile_page.dart';
import 'package:split_uz/presentation/home/home_page.dart';

class NavigationService {
  // 1. Create the global navigator key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // 2. Define your GoRouter instance inside the service
  late final GoRouter router = GoRouter(
    navigatorKey: navigatorKey, // <-- Pass the key here!
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const PhoneNumberPage(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) => const OtpPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          final user = state.extra as UserModel?;
          return HomePage(initialUser: user);
        },
      ),
      GoRoute(path: '/creatingUser', builder: (context, state){
        final data = state.extra as UserModel;
        return CreatingProfilePage(user: data);
      },)
    ],
  );

  // 3. Optional: Add helper methods if you want to abstract GoRouter away
  void push(String location, {Object? extra}) {
    router.push(location, extra: extra);
  }

  void go(String location, {Object? extra}) {
    router.go(location, extra: extra);
  }
}