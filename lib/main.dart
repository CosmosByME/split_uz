import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:split_uz/core/theme/theme.dart';
import 'package:split_uz/presentation/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        DefaultCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      theme: appThemeDark,
      home: const MyHomePage(),
    );
  }
}
