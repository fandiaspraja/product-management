abstract class PushNotificationRepository {
  Future<String> getDeviceToken();
  void configurePushNotifications();
  void subscribeToTopic(String topic);
  void unsubscribeFromTopic(String topic);
}
