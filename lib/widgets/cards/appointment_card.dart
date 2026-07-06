import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/appointment.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Time badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat('MMM').format(appointment.appointmentDate),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      DateFormat('dd').format(appointment.appointmentDate),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName ?? 'Doctor',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment.doctorSpecialization ?? '',
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded,
                            size: 14, color: AppTheme.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          appointment.timeSlot,
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Status
              _StatusBadge(status: appointment.status),
            ],
          ),
          if (appointment.reason != null) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.scaffoldBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                appointment.reason!,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final AppointmentStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case AppointmentStatus.scheduled:
        color = AppTheme.infoColor;
        text = 'Scheduled';
        break;
      case AppointmentStatus.confirmed:
        color = AppTheme.successColor;
        text = 'Confirmed';
        break;
      case AppointmentStatus.inProgress:
        color = AppTheme.warningColor;
        text = 'In Progress';
        break;
      case AppointmentStatus.completed:
        color = AppTheme.successColor;
        text = 'Completed';
        break;
      case AppointmentStatus.cancelled:
        color = AppTheme.errorColor;
        text = 'Cancelled';
        break;
      case AppointmentStatus.noShow:
        color = AppTheme.textSecondary;
        text = 'No Show';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
