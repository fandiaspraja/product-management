part of 'splash_bloc.dart';

abstract class SplashStateBloc extends Equatable {
  const SplashStateBloc();
  @override
  List<Object> get props => [];
}

class SplashLoading extends SplashStateBloc {}

class SplashEmpty extends SplashStateBloc {}

class SplashError extends SplashStateBloc {
  final String message;

  const SplashError(this.message);

  @override
  List<Object> get props => [message];
}

class LoginStatusSplash extends SplashStateBloc {
  final bool isLogin;

  const LoginStatusSplash(this.isLogin);

  @override
  List<Object> get props => [isLogin];
}

class UserDataSplashSuccess extends SplashStateBloc {
  final String name;

  const UserDataSplashSuccess(this.name);

  @override
  List<Object> get props => [name];
}

// push notif

// class PushNotificationInitial extends SplashStateBloc {}

// class PushNotificationLoading extends SplashStateBloc {}

// class PushNotificationLoaded extends SplashStateBloc {
//   final String deviceToken;
//   const PushNotificationLoaded(this.deviceToken);
// }

// class PushNotificationError extends SplashStateBloc {
//   final String message;
//   const PushNotificationError(this.message);
// }
