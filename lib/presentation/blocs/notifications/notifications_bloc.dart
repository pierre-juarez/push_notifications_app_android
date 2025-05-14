import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:push_app/config/domain/entities/push_message.dart';
import 'package:push_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message! ${message.messageId}");
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_onPushMessageRecieved);

    // Verificar estado de las notificaciones
    _initialStatusCheck();

    // Listener para notificaciones en background
    _onForegroundMessage();
  }

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  void _notificationStatusChanged(NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: event.status));
    _getFCMToken();
  }

  void _onPushMessageRecieved(NotificationReceived event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(notifications: [event.pushMessage, ...state.notifications]));
  }

  void _initialStatusCheck() async {
    final settings = await _firebaseMessaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;
    final token = await _firebaseMessaging.getToken();
    print("🚀 ~ file: notifications_bloc.dart ~ line: 35 ~ TM_FUNCTION: $token");
  }

  void handleRemoteMessage(RemoteMessage message) {
    print("Got a message whilst in the foreground!");
    print("Message data: ${message.data}");

    if (message.notification == null) return;
    print("Message also contained a notification: ${message.notification}");

    final notification = PushMessage(
      messageId: message.messageId?.replaceAll(":", "").replaceAll("%", "") ?? "",
      title: message.notification!.title ?? "",
      body: message.notification!.body ?? "",
      sendDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid ? message.notification!.android?.imageUrl : message.notification!.apple?.imageUrl,
    );

    print(notification);

    add(NotificationReceived(notification));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  PushMessage? getMessageById(String id) {
    final exist = state.notifications.any((element) => element.messageId == id);
    if (!exist) return null;

    return state.notifications.firstWhere((element) => element.messageId == id);
  }

}
