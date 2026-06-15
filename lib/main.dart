import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:split_uz/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:split_uz/core/widgets/on_tap.dart';
import 'package:split_uz/domain/services/navigation_service.dart';
import 'package:split_uz/firebase_options.dart';
import 'package:split_uz/presentation/auth/bloc/auth_bloc.dart';
import 'package:split_uz/presentation/creating_profile.dart/bloc/creating_user_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(OnTap(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = getIt<NavigationService>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CreatingUserBloc()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          DefaultCupertinoLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: appTheme,
        routerConfig: navigationService.router,
      ),
    );
  }
}
