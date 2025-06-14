import 'package:better_life/Notifications/NotificationService.dart';
import 'package:flutter/material.dart';
class PillReminder {
  final String name;
  final int amountPerDay;
  final int durationInDays;
  final int intervalHours;
  final TimeOfDay startTime;

  PillReminder({
    required this.name,
    required this.amountPerDay,
    required this.durationInDays,
    required this.intervalHours,
    required this.startTime,
  });
}


class PillReminderProvider extends ChangeNotifier {
  final List<PillReminder> _reminders = [];
  List<PillReminder> get reminders => _reminders;
  void addReminder(PillReminder reminder) {
    _reminders.add(reminder);
    notifyListeners();

    // مثال جدولة إشعار لكل وقت تذكير (هتحتاج تحدد الـ DateTime بشكل دقيق حسب startTime + interval + day)
    for (int day = 0; day < reminder.durationInDays; day++) {
      for (int dose = 0; dose < reminder.amountPerDay; dose++) {
        final scheduledDate = DateTime.now()
            .add(Duration(days: day, hours: dose * reminder.intervalHours)); // تعديل حسب startTime

        NotificationService.scheduleNotification(
          id: scheduledDate.millisecondsSinceEpoch ~/ 1000,
          title: 'Pill Reminder',
          body: 'Time to take ${reminder.name}',
          scheduledDateTime: scheduledDate,
        );
      }
    }
  }

  void removeReminder(int index) {
    _reminders.removeAt(index);
    notifyListeners();
  }

  void updateReminder(int index, PillReminder reminder) {
    if (index >= 0 && index < reminders.length) {
      reminders[index] = reminder;
      notifyListeners();
    }
  }

  void clearAll() {
    _reminders.clear();
    notifyListeners();
  }
}

