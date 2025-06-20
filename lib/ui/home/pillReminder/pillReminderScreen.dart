import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Notifications/NotificationService.dart';
import '../../../providers/pill_reminder_prov.dart';

class PillReminderScreen extends StatefulWidget {
  const PillReminderScreen({super.key});

  @override
  State<PillReminderScreen> createState() => _PillReminderScreenState();
}

class _PillReminderScreenState extends State<PillReminderScreen> {
  final TextEditingController pillNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController intervalController = TextEditingController();
  TimeOfDay? selectedStartTime;

  int? editingIndex; // هذا لتخزين العنصر الذي نعدل عليه، null يعني إضافة جديدة

  void pickStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedStartTime = picked;
      });
    }
  }

  void savePlan() {
    final name = pillNameController.text.trim();
    final amount = int.tryParse(amountController.text.trim()) ?? 0;
    final duration = int.tryParse(durationController.text.trim()) ?? 0;
    final interval = int.tryParse(intervalController.text.trim()) ?? 0;

    if (name.isEmpty || amount <= 0 || duration <= 0 || interval <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields correctly.")),
      );
      return;
    }

    final startTime = DateTime.now();

    for (int day = 0; day < duration; day++) {
      for (int dose = 0; dose < amount; dose++) {
        final reminderTime = startTime.add(
          Duration(days: day, hours: dose * interval),
        );

        // جدولة الإشعار هنا مباشرة
        NotificationService.scheduleNotification(
          id: reminderTime.millisecondsSinceEpoch ~/ 1000,
          title: 'Pill Reminder',
          body: 'It\'s time to take your pill: $name',
          scheduledDateTime: reminderTime,
        );

        // إضافة التذكير للـ Provider
        Provider.of<PillReminderProvider>(context, listen: false).addReminder(
          PillReminder(
            name: name,
            amountPerDay: amount,
            durationInDays: duration,
            intervalHours: interval,
            startTime: TimeOfDay.fromDateTime(reminderTime),
          ),
        );
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Plan added for $name")),
    );

    pillNameController.clear();
    amountController.clear();
    durationController.clear();
    intervalController.clear();
  }

  void clearFields() {
    pillNameController.clear();
    amountController.clear();
    durationController.clear();
    intervalController.clear();
    setState(() {
      selectedStartTime = null;
    });
  }

  void startEditing(int index, PillReminder reminder) {
    setState(() {
      editingIndex = index;
      pillNameController.text = reminder.name;
      amountController.text = reminder.amountPerDay.toString();
      durationController.text = reminder.durationInDays.toString();
      intervalController.text = reminder.intervalHours.toString();
      selectedStartTime = reminder.startTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Pill Reminder",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              editingIndex == null ? 'Add Plan' : 'Edit Plan',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            buildTextField(
              "Pill Name",
              pillNameController,
              icon: Icons.medication_outlined,
              hintText: "e.g., Panadol",
            ),
            buildTextField(
              "Amount per day",
              amountController,
              keyboardType: TextInputType.number,
              icon: Icons.format_list_numbered,
              hintText: "e.g., 3",
            ),
            buildTextField(
              "Duration (days)",
              durationController,
              keyboardType: TextInputType.number,
              icon: Icons.calendar_today,
              hintText: "e.g., 15",
            ),
            buildTextField(
              "Interval between doses (hours)",
              intervalController,
              keyboardType: TextInputType.number,
              icon: Icons.schedule,
              hintText: "e.g., 8",
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(selectedStartTime == null
                  ? "Pick start time"
                  : "Start time: ${selectedStartTime!.format(context)}"),
              trailing: TextButton(
                child: const Text("Choose"),
                onPressed: pickStartTime,
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: savePlan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2AB694),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24),
                      child: Text(
                        editingIndex == null ? 'Done' : 'Update',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (editingIndex != null)
                  const SizedBox(width: 12),
                if (editingIndex != null)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        clearFields();
                        setState(() {
                          editingIndex = null;
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Text('Cancel'),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(thickness: 1.2),
            const Text('Added Plans', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Expanded(
              child: Consumer<PillReminderProvider>(
                builder: (context, provider, _) {
                  if (provider.reminders.isEmpty) {
                    return const Center(child: Text('No plans added yet.'));
                  }
                  return ListView.builder(
                    itemCount: provider.reminders.length,
                    itemBuilder: (context, index) {
                      final reminder = provider.reminders[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: const Icon(Icons.medication),
                          title: Text(reminder.name),
                          subtitle: Text(
                            'Start at: ${reminder.startTime.format(context)}, '
                                '${reminder.amountPerDay} times/day, every ${reminder.intervalHours}h for ${reminder.durationInDays} days',
                          ),
                          trailing: Wrap(
                            spacing: 12,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => startEditing(index, reminder),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  Provider.of<PillReminderProvider>(context, listen: false).removeReminder(index);
                                  if (editingIndex == index) {
                                    clearFields();
                                    setState(() {
                                      editingIndex = null;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String label,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
        IconData? icon,
        String? hintText,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pillNameController.dispose();
    amountController.dispose();
    durationController.dispose();
    intervalController.dispose();
    super.dispose();
  }
}
