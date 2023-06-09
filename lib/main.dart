import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_source/app_router.dart';
import 'package:flutter_ui_source/toggle_theme/app_themes.dart';
import 'package:flutter_ui_source/toggle_theme/cubit/theme_cubit.dart';
import 'package:flutter_ui_source/toggle_theme/toggle_theme_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences preferences;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(preferences.getString('lang') ?? 'en'),
      child: const MyApp(),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, AppTheme>(
        builder: (context, themeState) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode:
                themeState == AppTheme.light ? ThemeMode.light : ThemeMode.dark,
            onGenerateRoute: AppRouter.onGenerateRoute,
            home: const ToggleThemeScreen(),
          );
        },
      ),
    );
  }
}
