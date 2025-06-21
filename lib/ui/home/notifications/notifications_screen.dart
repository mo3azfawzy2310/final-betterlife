import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_life/ui/logic/notifications/notifications_cubit.dart';
import 'package:better_life/models/notification_model.dart';
import 'package:better_life/core/services/user_service.dart';
import 'package:better_life/ui/utils/dialog_utils.dart';

class NotificationsScreen extends StatefulWidget {
  static const String routeName = 'notifications-screen';

  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int? currentPatientId;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = await UserService.getCurrentUser();
    if (!mounted) return;
    
    if (user?.patientId != null) {
      setState(() {
        currentPatientId = user!.patientId;
      });
      if (currentPatientId != null) {
        context.read<NotificationsCubit>().getAllNotifications(currentPatientId!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color(0xFF199A8E),
        foregroundColor: Colors.white,
        actions: [
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsLoaded && state.notifications.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.mark_email_read),
                  onPressed: () => _markAllAsRead(state.notifications),
                  tooltip: 'Mark all as read',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          if (state is NotificationReadSuccess) {
            // Refresh notifications after marking as read
            if (currentPatientId != null) {
              context.read<NotificationsCubit>().getAllNotifications(currentPatientId!);
            }
          } else if (state is NotificationDeletedSuccess) {
            // Refresh notifications after deletion
            if (currentPatientId != null) {
              context.read<NotificationsCubit>().getAllNotifications(currentPatientId!);
            }
          } else if (state is NotificationsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationsLoaded) {
            if (state.notifications.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_none, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No notifications yet',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final notification = state.notifications[index];
                return NotificationCard(
                  notification: notification,
                  onTap: () => _showNotificationDetails(notification),
                  onDelete: () => _deleteNotification(notification),
                  onMarkAsRead: () => _markAsRead(notification),
                );
              },
            );
          } else if (state is NotificationsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading notifications',
                    style: TextStyle(fontSize: 18, color: Colors.red[700]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (currentPatientId != null) {
                        context.read<NotificationsCubit>().getAllNotifications(currentPatientId!);
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text('No notifications to display'),
          );
        },
      ),
    );
  }

  void _showNotificationDetails(NotificationModel notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notification.title ?? 'Notification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message ?? 'No message'),
            const SizedBox(height: 16),
            Text(
              'Date: ${notification.date ?? 'Unknown'}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            if (notification.type != null) ...[
              const SizedBox(height: 8),
              Text(
                'Type: ${notification.type}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (notification.isRead == false)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _markAsRead(notification);
              },
              child: const Text('Mark as Read'),
            ),
        ],
      ),
    );
  }

  void _markAsRead(NotificationModel notification) {
    if (notification.id != null) {
      context.read<NotificationsCubit>().readNotification(notification.id!);
    }
  }

  void _markAllAsRead(List<NotificationModel> notifications) {
    context.read<NotificationsCubit>().markAllAsRead(notifications);
  }

  void _deleteNotification(NotificationModel notification) {
    DialogUtils.showConfirmDialog(
      context: context,
      title: 'Delete Notification',
      message: 'Are you sure you want to delete this notification?',
      onConfirm: () {
        if (notification.id != null) {
          context.read<NotificationsCubit>().deleteNotification(notification.id!);
        }
      },
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onMarkAsRead;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onDelete,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: notification.isRead == false ? 4 : 1,
      color: notification.isRead == false ? Colors.blue[50] : null,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: notification.isRead == false 
              ? Colors.blue 
              : Colors.grey,
          child: Icon(
            _getNotificationIcon(notification.type),
            color: Colors.white,
          ),
        ),
        title: Text(
          notification.title ?? 'Notification',
          style: TextStyle(
            fontWeight: notification.isRead == false 
                ? FontWeight.bold 
                : FontWeight.normal,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.message ?? 'No message',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              notification.date ?? 'Unknown date',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'read':
                onMarkAsRead();
                break;
              case 'delete':
                onDelete();
                break;
            }
          },
          itemBuilder: (context) => [
            if (notification.isRead == false)
              const PopupMenuItem(
                value: 'read',
                child: Row(
                  children: [
                    Icon(Icons.mark_email_read),
                    SizedBox(width: 8),
                    Text('Mark as Read'),
                  ],
                ),
              ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  IconData _getNotificationIcon(String? type) {
    switch (type?.toLowerCase()) {
      case 'appointment':
        return Icons.calendar_today;
      case 'medical':
        return Icons.medical_services;
      case 'reminder':
        return Icons.alarm;
      case 'system':
        return Icons.info;
      default:
        return Icons.notifications;
    }
  }
} 