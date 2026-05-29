import 'package:flutter/material.dart';
import 'package:axis_crm/entity/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Profile',
              style: TextStyle(
                color: Color(0xFF17233C),
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            Text('Tên: ${user.name}'),
            const SizedBox(height: 8),
            Text('Số điện thoại: ${user.phone}'),
            const SizedBox(height: 8),
            Text('Vai trò: ${user.isOwner ? 'Chủ thầu' : 'Thợ'}'),
          ],
        ),
      ),
    );
  }
}
