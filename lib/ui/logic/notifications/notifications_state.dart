part of 'notifications_cubit.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

// All notifications states
class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> notifications;
  NotificationsLoaded(this.notifications);
}

class NotificationsError extends NotificationsState {
  final String message;
  NotificationsError(this.message);
}

// Single notification states
class NotificationLoading extends NotificationsState {}

class NotificationLoaded extends NotificationsState {
  final NotificationModel notification;
  NotificationLoaded(this.notification);
}

class NotificationError extends NotificationsState {
  final String message;
  NotificationError(this.message);
}

// Action states
class NotificationReadSuccess extends NotificationsState {}

class NotificationDeletedSuccess extends NotificationsState {}

class AllNotificationsReadSuccess extends NotificationsState {} 