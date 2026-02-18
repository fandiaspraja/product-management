import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:labamu/features/product/domain/entity/product_entity.dart';
import 'package:labamu/features/product/presentation/pages/update_product_page.dart';
import 'package:labamu/features/splash/presentation/pages/splash_page.dart';
import 'package:labamu/features/product/presentation/pages/detail_page.dart';
import 'package:labamu/features/product/presentation/pages/home_page.dart';
import 'package:labamu/features/product/presentation/pages/create_product_page.dart';
import 'package:labamu/features/theme/presentation/pages/theme_page.dart';

Page<dynamic> buildPageWithTransition(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.2), // Mulai dari bawah sedikit
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    },
  );
}

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  observers: [ChuckerFlutter.navigatorObserver],
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) =>
          buildPageWithTransition(SplashPage(), state),
    ),

    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return buildPageWithTransition(HomePage(), state);
      },
    ),

    GoRoute(
      path: '/detail',
      pageBuilder: (context, state) {
        String id = state.extra as String;

        return buildPageWithTransition(DetailPage(id: id), state);
      },
    ),
    GoRoute(
      path: '/create-product',
      pageBuilder: (context, state) {
        return buildPageWithTransition(CreateProductPage(), state);
      },
    ),
    GoRoute(
      path: '/update-product',
      pageBuilder: (context, state) {
        ProductEntity product = state.extra as ProductEntity;

        return buildPageWithTransition(
          UpdateProductPage(product: product),
          state,
        );
      },
    ),
    GoRoute(
      path: '/theme',
      pageBuilder: (context, state) {
        return buildPageWithTransition(ThemePage(), state);
      },
    ),
  ],
);
