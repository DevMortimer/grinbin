import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:grinbin/home/homePage.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(routes: {
      '/': (context, state, data) => const HomePage(),
    }).call,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
      ),
    );
  }
}
