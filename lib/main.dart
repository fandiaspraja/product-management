import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labamu/config/app_config.dart';
import 'package:labamu/core/utils/constants.dart';
import 'package:labamu/core/utils/constants.dart' as AppColors;
import 'package:labamu/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:labamu/features/product/presentation/bloc/product_bloc.dart';
import 'package:labamu/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:labamu/firebase_options.dart';
import 'package:labamu/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await di.init();
  AppConfig.create(
    appName: 'Labamu',
    baseUrl: 'http://localhost:3000',
    paymentKey: '',
    flavor: Flavor.dev,
  );

  _configLoading();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<SplashBloc>()),
        BlocProvider(create: (_) => di.locator<ProductBloc>()),
        BlocProvider(create: (_) => di.locator<ThemeBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return BlocBuilder<ThemeBloc, ThemeStateBloc>(
            builder: (context, state) {
              ThemeMode themeMode = ThemeMode.light;

              if (state is ThemeLoaded) {
                themeMode = state.themeMode;
              }

              return MaterialApp.router(
                routerConfig: router,
                debugShowCheckedModeBanner: false,

                // title: 'PMB App',
                themeMode: themeMode,
                theme: ThemeData.light().copyWith(
                  primaryColor: primary,
                  scaffoldBackgroundColor: bgPrimary,
                  drawerTheme: kDrawerTheme,
                  cardTheme: CardThemeData(
                    color: AppColors.bgCard,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                darkTheme: ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: Colors.black,
                  cardTheme: CardThemeData(
                    color: Colors.grey[900],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                // TODO: CHANGE TO DEFAULT
                builder: EasyLoading.init(),
              );
            },
          );
        },
      ),
    );
  }
}

void _configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    // ..indicatorSize = 45.0
    ..radius = 10.0
    // ..progressColor = Colors.yellow
    ..backgroundColor = darkGreyThird
    ..indicatorColor = primary
    ..textColor = primary
    // ..maskColor = Colors.red
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
