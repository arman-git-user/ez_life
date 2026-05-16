import 'package:ez_life/view/ai_chat_view.dart';
import 'package:ez_life/view/dashboard_view.dart';
import 'package:ez_life/view/ezlife_view.dart';
import 'package:ez_life/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoutesConfig {
  static final GoRouter routes = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage(child: SplashView()),
      ),
      GoRoute(
        path: '/ezLife',
        pageBuilder: (context, state) => MaterialPage(child: EzLifeScreen()),
      ),



      GoRoute(
        path: '/dashboard',
        pageBuilder: (context, state) => MaterialPage(child: Dashboard_View()),
      ),
      GoRoute(
        path: '/dashboard/AIChat',
        pageBuilder: (context, state) => MaterialPage(child: AIChatView()),
      ),
    ],
  );
}
