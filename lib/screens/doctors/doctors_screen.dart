import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../widgets/cards/doctor_card.dart';
import '../../widgets/common/custom_text_field.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Doctors'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomTextField(
              controller: TextEditingController(),
              label: '',
              hint: 'Search by name or specialization...',
              prefixIcon: Icons.search_rounded,
            ),
          ),
          // Specialization chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _SpecializationChip(label: 'All', isSelected: true),
                _SpecializationChip(label: 'Cardiology'),
                _SpecializationChip(label: 'Neurology'),
                _SpecializationChip(label: 'Orthopedics'),
                _SpecializationChip(label: 'Pediatrics'),
                _SpecializationChip(label: 'Dermatology'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10, // placeholder
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DoctorCard(
                    name: 'Dr. Sarah Johnson',
                    specialization: 'Cardiologist',
                    rating: 4.8,
                    isAvailable: index % 3 != 0,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecializationChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _SpecializationChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) {},
        selectedColor: AppTheme.primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppTheme.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        showCheckmark: false,
      ),
    );
  }
}
