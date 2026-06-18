import 'package:flutter/material.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/presentation/widgets/app_button.dart';
import 'package:axis_crm/presentation/widgets/section_card.dart';
import 'package:axis_crm/presentation/widgets/page_title.dart';
import 'package:axis_crm/presentation/screens/yearly_summary/yearly_summary_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    // Lấy ký tự đầu của tên làm avatar
    final String initialChar = user.name.isNotEmpty
        ? user.name.trim().split(' ').last[0].toUpperCase()
        : 'U';

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        title: const PageTitle(title: 'Cá nhân'),
        backgroundColor: const Color(0xFFF4F7FC),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: <Widget>[
            // Avatar và Tên phần Header
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        initialChar,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF17233C),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.isOwner ? 'Chủ thầu' : 'Công nhân',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF667299),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Card Thông tin chi tiết
            SectionCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    _buildInfoRow(
                      icon: Icons.person_outline,
                      label: 'Họ và tên',
                      value: user.name,
                    ),
                    const Divider(color: Color(0xFFE2E8F0), height: 24),
                    _buildInfoRow(
                      icon: Icons.phone_android_outlined,
                      label: 'Tên đăng nhập / SĐT',
                      value: user.phone,
                    ),
                    const Divider(color: Color(0xFFE2E8F0), height: 24),
                    _buildInfoRow(
                      icon: Icons.badge_outlined,
                      label: 'Vai trò',
                      value: user.isOwner ? 'Chủ thầu' : 'Công nhân',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppButton(
              label: 'Tổng kết năm',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const YearlySummaryScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF667299), size: 22),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8A95A8),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF17233C),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
