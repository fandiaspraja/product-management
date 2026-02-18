import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:labamu/core/utils/constants.dart' as AppColors;
import 'package:labamu/features/push_notification/domain/usecase/push_notification_usecase.dart';
import 'package:labamu/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:labamu/features/product/presentation/pages/home_page.dart';
import 'package:labamu/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:labamu/injection.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _pushNotificationUseCase = locator<PushNotificationUseCase>();
  String? fcmToken;

  @override
  void initState() {
    context.read<ThemeBloc>().add(LoadThemeEvent());
    super.initState();

    _setupPushNotifications();

    Future.microtask(() {
      context.go(HomePage.ROUTE_NAME);
    });
  }

  Future<void> _setupPushNotifications() async {
    try {
      // Get device token (optional)
      final token = await _pushNotificationUseCase.getDeviceToken();
      debugPrint("FCM Device Token: $token");
      fcmToken = token;

      // Set listener on foreground/background notifications
      _pushNotificationUseCase.configurePushNotifications();

      // (Optional) Subscribe to topic
      // _pushNotificationUseCase.subscribeToTopic("user");
    } catch (e) {
      debugPrint("Push Notification Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashStateBloc>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.primary50,
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Image.asset(
                  "assets/images/labamu-logo.png",
                  // height: 200,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
