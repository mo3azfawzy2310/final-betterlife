import 'package:better_life/models/appointment_model.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/cancel&Reschdule_botton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleItem extends StatefulWidget {
  final AppointmentModel appointment;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;

  const ScheduleItem({
    Key? key,
    required this.appointment,
    this.onCancel,
    this.onReschedule,
  }) : super(key: key);

  @override
  State<ScheduleItem> createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {
  @override
  Widget build(BuildContext context) {
    // Parse the appointment date and time
    final dateTime = DateTime.tryParse(widget.appointment.appointmentDateTime) ?? DateTime.now();
    
    // Format the date and time
    final formattedDate = DateFormat('EEEE, MMM d, yyyy').format(dateTime);
    final formattedTime = DateFormat('h:mm a').format(dateTime);
    
    // Determine status color
    Color statusColor = Colors.grey;
    String statusText = widget.appointment.status?.toLowerCase() ?? 'pending';
    
    if (statusText == 'confirmed') {
      statusColor = Colors.green;
    } else if (statusText == 'cancelled' || statusText == 'canceled') {
      statusColor = Colors.red;
    } else if (statusText == 'pending') {
      statusColor = Colors.orange;
    }
    
    // Capitalize first letter of status
    statusText = statusText.isEmpty ? 'Pending' : 
      '${statusText[0].toUpperCase()}${statusText.substring(1).toLowerCase()}';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 220, 220, 220)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor info row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.appointment.doctorName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Doctor ID: ${widget.appointment.doctorId}',
                        style: const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/homeScreen/Doctor.png'),
                ),
              ],
            ),
            
            const SizedBox(height: 15),
            
            // Date and time info
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    formattedDate,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 109, 109, 109),
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Time and status
            Row(
              children: [
                const Icon(
                  Icons.watch_later_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  formattedTime,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 109, 109, 109),
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Spacer(),
                // Status indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle
                        )
                      ),
                      const SizedBox(width: 5),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Reason section
            if (widget.appointment.reason != null && widget.appointment.reason!.isNotEmpty) ...[
              const SizedBox(height: 10),
              const Text(
                "Reason:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                widget.appointment.reason!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            
            // Notes section
            if (widget.appointment.notes != null && widget.appointment.notes!.isNotEmpty) ...[
              const SizedBox(height: 10),
              const Text(
                "Notes:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                widget.appointment.notes!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            
            const SizedBox(height: 15),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildActionButtons() {
    final status = widget.appointment.status?.toLowerCase() ?? 'pending';
    
    // No action buttons for completed or canceled appointments
    if (status == 'completed') {
      return Row(
        children: [
          Expanded(
            child: Cancel_reschduleBotton(
              onpressed: () {}, 
              text: "Completed", 
              containercolor: Colors.blue.withOpacity(0.2), 
              textcolor: Colors.blue
            )
          )
        ],
      );
    } else if (status == 'cancelled' || status == 'canceled') {
      return Row(
        children: [
          Expanded(
            child: Cancel_reschduleBotton(
              onpressed: () {}, 
              text: "Cancelled", 
              containercolor: Colors.red.withOpacity(0.2), 
              textcolor: Colors.red
            )
          )
        ],
      );
    }
    
    // For confirmed or pending appointments, show both buttons
    return Row(
      children: [
        Expanded(
          child: Cancel_reschduleBotton(
            onpressed: widget.onCancel ?? (){}, 
            text: "Cancel", 
            containercolor: const Color.fromARGB(255, 255, 220, 220), 
            textcolor: Colors.red
          )
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Cancel_reschduleBotton(
            onpressed: widget.onReschedule ?? (){}, 
            text: "Reschedule", 
            containercolor: const Color(0xff199A8E), 
            textcolor: Colors.white
          )
        )
      ],
    );
  }
}
