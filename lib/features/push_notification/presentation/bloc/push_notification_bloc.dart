import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'push_notification_event.dart';
part 'push_notification_state.dart';
class push_notificationBloc extends Bloc<push_notificationEventBloc, push_notificationStateBloc> {
push_notificationBloc(super.initialState);
}
