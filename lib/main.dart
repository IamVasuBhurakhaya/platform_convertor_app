import 'package:contact_diary_pr/routes/ios_app_routes.dart';
import 'package:contact_diary_pr/routes/and_app_routes.dart';
import 'package:contact_diary_pr/screens/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeProvider()),
      ],
      child: Consumer<HomeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return value.isAndroid
              ? MaterialApp(
                  theme: ThemeData(
                      brightness:
                          value.isDark ? Brightness.dark : Brightness.light),
                  debugShowCheckedModeBanner: false,
                  routes: AndAppRoutes.andRoutes,
                )
              : CupertinoApp(
                  debugShowCheckedModeBanner: false,
                  routes: IosAppRoutes.IosRoutes,
                  theme: CupertinoThemeData(
                      brightness:
                          value.isDark ? Brightness.dark : Brightness.light),
                );
        },
      ),
    );
  }
}
