import 'package:flutter/material.dart';
import 'package:flutter_ui_source/app_router.dart';
import 'package:flutter_ui_source/onboard/on_board_screen.dart';



main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: const OnBoardScreen(),
    );
  }
}
