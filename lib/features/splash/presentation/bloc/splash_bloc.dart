import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labamu/core/local_storage/shared_preferences/shared_preferences_helper.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEventBloc, SplashStateBloc> {
  final SharedPreferencesHelper sharedPreferencesHelper;
  // final PushNotificationUseCase pushNotificationUseCase;

  SplashBloc(
    this.sharedPreferencesHelper,
    // , this.pushNotificationUseCase
  ) : super(SplashLoading()) {
    on<GetLoginStatusSplashEvent>((event, emit) async {
      emit(SplashLoading());

      try {
        final isLogin = sharedPreferencesHelper.getToken();
        if (isLogin != null) {
          emit(const LoginStatusSplash(true));
        } else {
          emit(const LoginStatusSplash(false));
        }
      } catch (e) {
        emit(SplashError(e.toString())); // Emit an error state
      }
    });

    on<GetUserDataSplashEvent>((event, emit) async {
      emit(SplashLoading());

      try {
        final name = sharedPreferencesHelper
            .getUserName(); // Assuming you have getUserName
        if (name != null) {
          // Check if name is null
          emit(UserDataSplashSuccess(name));
        } else {
          emit(
            const UserDataSplashSuccess(""),
          ); // Or handle the null case differently
          // Alternatively, emit a different state indicating no username found
        }
      } catch (e) {
        emit(SplashError(e.toString()));
      }
    });

    // push notif

    // on<GetDeviceToken>((event, emit) async {
    //   emit(PushNotificationLoading());
    //   try {
    //     final token = await pushNotificationUseCase.getDeviceToken();
    //     emit(PushNotificationLoaded(token));
    //   } catch (e) {
    //     emit(PushNotificationError(e.toString()));
    //   }
    // });

    // on<ConfigurePushNotification>((event, emit) {
    //   pushNotificationUseCase.configurePushNotifications();
    // });

    // on<SubscribeToTopic>((event, emit) {
    //   pushNotificationUseCase.subscribeToTopic(event.topic);
    // });

    // on<UnsubscribeFromTopic>((event, emit) {
    //   pushNotificationUseCase.unsubscribeFromTopic(event.topic);
    // });
  }
}
