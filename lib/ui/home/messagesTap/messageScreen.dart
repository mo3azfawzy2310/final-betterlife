import 'package:better_life/ChatBot/ChatScreenBot.dart';
import 'package:better_life/ui/home/messagesTap/ChatScreen.dart';
import 'package:flutter/material.dart';

// For backward compatibility with the HomeScreen reference
class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messages = [
      {
        'name': 'Dr. Ali Ebrahim',
        'lastMessage': "I don't have any fever, but headache...",
        'time': '10:24',
        'image': 'assets/images/homeScreen/Doctor.png',
        'isRead': false,
      },
      {
        'name': 'Dr. Khaled Mansy',
        'lastMessage': 'Hello, How can I help you?',
        'time': '09:04',
        'image': 'assets/images/homeScreen/Doctor.png',
        'isRead': true,
      },
      {
        'name': 'Dr. Saad Ahmed',
        'lastMessage': 'Do you have fever?',
        'time': '08:57',
        'image': 'assets/images/homeScreen/Doctor.png',
        'isRead': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Message',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: messages.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final message = messages[index];
          return ListTile(
            onTap: () {
              // Navigate to ChatScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    doctorName: message['name'],
                    doctorImage: message['image'],
                  ),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundImage: AssetImage(message['image']),
              radius: 26,
            ),
            title: Text(
              message['name'],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              message['lastMessage'],
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message['time'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                message['isRead']
                    ? const Icon(Icons.done_all, size: 18, color: Colors.grey)
                    : const Icon(Icons.circle, size: 10, color: Colors.green),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ChatScreenBot.routeName);
        },
        child: const Icon(Icons.smart_toy_outlined),
      ),
    );
  }
}
