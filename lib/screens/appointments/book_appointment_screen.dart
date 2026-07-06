import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../config/theme.dart';
import '../../providers/appointment_provider.dart';
import '../../widgets/common/custom_button.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTimeSlot;
  String? _selectedDoctor;
  String? _selectedType;
  final _reasonController = TextEditingController();

  final _timeSlots = [
    '09:00 AM', '09:30 AM', '10:00 AM', '10:30 AM',
    '11:00 AM', '11:30 AM', '02:00 PM', '02:30 PM',
    '03:00 PM', '03:30 PM', '04:00 PM', '04:30 PM',
  ];

  final _appointmentTypes = [
    'Consultation',
    'Follow-up',
    'Emergency',
    'Lab Test',
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 90)),
                focusedDay: _selectedDate,
                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                onDaySelected: (selected, focused) {
                  setState(() => _selectedDate = selected);
                },
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: AppTheme.primaryLight,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Appointment type
            const Text('Appointment Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _appointmentTypes.map((type) {
                final isSelected = _selectedType == type;
                return ChoiceChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() => _selectedType = selected ? type : null);
                  },
                  selectedColor: AppTheme.primaryColor,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Time slots
            const Text('Select Time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _timeSlots.map((slot) {
                final isSelected = _selectedTimeSlot == slot;
                return ChoiceChip(
                  label: Text(slot),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() => _selectedTimeSlot = selected ? slot : null);
                  },
                  selectedColor: AppTheme.primaryColor,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Reason
            const Text('Reason for Visit',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            TextField(
              controller: _reasonController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Describe your symptoms or reason for visit...',
              ),
            ),
            const SizedBox(height: 32),

            // Book button
            Consumer<AppointmentProvider>(
              builder: (context, provider, _) {
                return CustomButton(
                  text: 'Confirm Appointment',
                  isLoading: provider.isLoading,
                  onPressed: () async {
                    if (_selectedTimeSlot == null || _selectedType == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select time and type'),
                          backgroundColor: AppTheme.warningColor,
                        ),
                      );
                      return;
                    }

                    final success = await provider.bookAppointment({
                      'appointment_date': _selectedDate.toIso8601String(),
                      'time_slot': _selectedTimeSlot,
                      'type': _selectedType!.toLowerCase(),
                      'reason': _reasonController.text,
                    });

                    if (success && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Appointment booked successfully!'),
                          backgroundColor: AppTheme.successColor,
                        ),
                      );
                      context.pop();
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
