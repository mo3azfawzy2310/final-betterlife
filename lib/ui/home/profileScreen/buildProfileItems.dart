import 'package:flutter/material.dart';

Widget buildProfileItems(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}){
  return ListTile(
    leading: Icon(icon, color: isLogout? Colors.red : const Color(0xFF199A8E),),
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: isLogout? Colors.red : Colors.black,
      ),
    ),
    trailing: const Icon(Icons.chevron_right),
    onTap: onTap,
  );
}