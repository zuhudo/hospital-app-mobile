import 'package:flutter/material.dart';
import '../../config/theme.dart';

class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: iconColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
