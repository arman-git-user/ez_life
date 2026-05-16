import 'package:ez_life/utils/routes/routes_config.dart';
import 'package:ez_life/view/ai_chat_view.dart';
import 'package:ez_life/view/dashboard_view.dart';
import 'package:ez_life/view/ezlife_view.dart';
import 'package:ez_life/view_model/ai_chat_view_model.dart';
import 'package:ez_life/view_model/ezlife_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AiChatViewModel>(
          create: (context) => AiChatViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => EzlifeViewModel(),)
      ],
      child: MaterialApp.router(
        routeInformationProvider: RoutesConfig.routes.routeInformationProvider,
        routeInformationParser: RoutesConfig.routes.routeInformationParser,
        routerDelegate: RoutesConfig.routes.routerDelegate,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
      ),
    );
  }
}
