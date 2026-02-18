import 'dart:io';

import 'package:flutter/widgets.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

bool isIPad(BuildContext context) {
  if (!Platform.isIOS) return false; // Only care about iOS
  final size = MediaQuery.of(context).size;
  final shortestSide = size.shortestSide;
  return shortestSide >= 600; // iPads usually have shortestSide >= 600
}
