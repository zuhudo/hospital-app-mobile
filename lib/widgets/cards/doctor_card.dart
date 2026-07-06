import 'package:flutter/material.dart';
import '../../config/theme.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialization;
  final double rating;
  final bool isAvailable;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialization,
    required this.rating,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 30,
              color: AppTheme.accentColor,
            ),
          ),
          const SizedBox(width: 14),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  specialization,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isAvailable
                            ? AppTheme.successColor.withOpacity(0.1)
                            : AppTheme.errorColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isAvailable ? 'Available' : 'Unavailable',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isAvailable
                              ? AppTheme.successColor
                              : AppTheme.errorColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Book button
          ElevatedButton(
            onPressed: isAvailable ? () {} : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              textStyle: const TextStyle(fontSize: 13),
            ),
            child: const Text('Book'),
          ),
        ],
      ),
    );
  }
}
