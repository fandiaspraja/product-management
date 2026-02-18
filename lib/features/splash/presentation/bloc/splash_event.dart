part of 'splash_bloc.dart';

abstract class SplashEventBloc extends Equatable {
  const SplashEventBloc();
  @override
  List<Object> get props => [];
}

class GetLoginStatusSplashEvent extends SplashEventBloc {}

class GetUserDataSplashEvent extends SplashEventBloc {}

// push notif event

// class GetDeviceToken extends SplashEventBloc {}

// class ConfigurePushNotification extends SplashEventBloc {}

// class SubscribeToTopic extends SplashEventBloc {
//   final String topic;
//   const SubscribeToTopic(this.topic);
// }

// class UnsubscribeFromTopic extends SplashEventBloc {
//   final String topic;
//   const UnsubscribeFromTopic(this.topic);
// }
