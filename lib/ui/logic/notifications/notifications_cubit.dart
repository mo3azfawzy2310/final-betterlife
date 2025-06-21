import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_life/core/services/user_service.dart';
import 'package:better_life/models/notification_model.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  // Get all notifications for a patient
  Future<void> getAllNotifications(int patientId) async {
    emit(NotificationsLoading());
    try {
      final notifications = await UserService.getAllNotifications(patientId);
      emit(NotificationsLoaded(notifications));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }

  // Get notification by ID
  Future<void> getNotificationById(int notificationId) async {
    emit(NotificationLoading());
    try {
      final notification = await UserService.getNotificationById(notificationId);
      emit(NotificationLoaded(notification));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  // Read notification
  Future<void> readNotification(int notificationId) async {
    emit(NotificationsLoading());
    try {
      await UserService.readNotification(notificationId);
      // Refresh notifications list
      // Note: You might want to pass the patientId here or store it in the cubit
      emit(NotificationReadSuccess());
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }

  // Delete notification
  Future<void> deleteNotification(int notificationId) async {
    emit(NotificationsLoading());
    try {
      await UserService.deleteNotification(notificationId);
      // Refresh notifications list
      // Note: You might want to pass the patientId here or store it in the cubit
      emit(NotificationDeletedSuccess());
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }

  // Mark all notifications as read
  Future<void> markAllAsRead(List<NotificationModel> notifications) async {
    emit(NotificationsLoading());
    try {
      for (final notification in notifications) {
        if (notification.id != null && notification.isRead == false) {
          await UserService.readNotification(notification.id!);
        }
      }
      emit(AllNotificationsReadSuccess());
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }
} 