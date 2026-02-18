import 'package:labamu/features/push_notification/domain/repository/push_notification_repository.dart';

class PushNotificationUseCase {
  final PushNotificationRepository repository;

  PushNotificationUseCase({required this.repository});

  Future<String> getDeviceToken() {
    return repository.getDeviceToken();
  }

  void configurePushNotifications() {
    repository.configurePushNotifications();
  }

  void subscribeToTopic(String topic) {
    repository.subscribeToTopic(topic);
  }

  void unsubscribeFromTopic(String topic) {
    repository.unsubscribeFromTopic(topic);
  }
}
