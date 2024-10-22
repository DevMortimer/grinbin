import 'package:Grinbin/aboutPage/aboutPage.dart';
import 'package:Grinbin/global.dart';
import 'package:Grinbin/newLog/logDetails/logDetailsPage.dart';
import 'package:Grinbin/newLog/newLogPage.dart';
import 'package:Grinbin/viewLog/viewLogPage.dart';
import 'package:flutter/material.dart';
import 'package:Grinbin/home/homePage.dart';
import 'package:Grinbin/login/loginPage.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://rmkghbddycxuhqogblmh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJta2doYmRkeWN4dWhxb2dibG1oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjk0ODgxODMsImV4cCI6MjA0NTA2NDE4M30.eXR2mzQ1-JbmtaH0cL07ARGlCEp_P2eSRWQok3IB-qw',
  );
  runApp(MyApp());
}

final router = GoRouter(
  redirect: (context, state) {
    if (supabase.auth.currentUser == null ||
        supabase.auth.currentSession == null) {
      return '/login';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoaderOverlay(
        child: HomePage(
          user: state.extra as User?,
        ),
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoaderOverlay(child: LoginPage()),
    ),
    GoRoute(
      path: '/newLog',
      builder: (context, state) => LoaderOverlay(
        child: NewLogPage(user: state.extra as Map<String, dynamic>),
      ),
    ),
    GoRoute(
      path: '/logDetails',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final feel = extra['feel'];
        final user = extra['user'] as Map<String, dynamic>;
        return LoaderOverlay(child: LogDetailsPage(feel: feel, user: user));
      },
    ),
    GoRoute(path: '/about', builder: (context, state) => AboutPage()),
    GoRoute(
      path: '/viewLog',
      builder: (context, state) => LoaderOverlay(
        child: ViewLogPage(logToView: state.extra as Map<String, dynamic>),
      ),
    ),
  ],
);

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) => ScreenUtilInit(
        designSize: const Size(2400, 1080),
        minTextAdapt: true,
        child: child!,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
