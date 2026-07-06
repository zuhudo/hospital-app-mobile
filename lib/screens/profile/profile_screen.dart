import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppTheme.primaryLight,
                    child: Icon(Icons.person,
                        size: 50, color: AppTheme.primaryColor),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'john.doe@email.com',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Patient',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Menu items
            _ProfileMenuItem(
              icon: Icons.medical_information_outlined,
              title: 'Medical Records',
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.calendar_month_outlined,
              title: 'My Appointments',
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.receipt_long_outlined,
              title: 'Billing & Payments',
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.language_outlined,
              title: 'Language',
              subtitle: 'English',
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              trailing: Switch(
                value: false,
                onChanged: (val) {},
                activeColor: AppTheme.primaryColor,
              ),
            ),
            _ProfileMenuItem(
              icon: Icons.help_outline_rounded,
              title: 'Help & Support',
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            // Logout
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await context.read<AuthProvider>().logout();
                  if (context.mounted) context.go('/login');
                },
                icon: const Icon(Icons.logout_rounded,
                    color: AppTheme.errorColor),
                label: const Text('Sign Out',
                    style: TextStyle(color: AppTheme.errorColor)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.errorColor),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.primaryColor, size: 22),
        ),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: trailing ??
            const Icon(Icons.chevron_right_rounded,
                color: AppTheme.textSecondary),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
