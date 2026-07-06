import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../providers/patient_provider.dart';

class PatientDetailScreen extends StatefulWidget {
  final String patientId;
  const PatientDetailScreen({super.key, required this.patientId});

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PatientProvider>().fetchPatientById(widget.patientId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Consumer<PatientProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final patient = provider.selectedPatient;
          if (patient == null) {
            return const Center(child: Text('Patient not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Profile header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryColor, AppTheme.primaryDark],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Text(
                          '${patient.firstName[0]}${patient.lastName[0]}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        patient.fullName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${patient.age} years • ${patient.gender}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _InfoChip(
                            icon: Icons.bloodtype_rounded,
                            label: patient.bloodGroup ?? 'N/A',
                          ),
                          _InfoChip(
                            icon: Icons.phone_rounded,
                            label: patient.phone,
                          ),
                          _InfoChip(
                            icon: Icons.email_rounded,
                            label: patient.email,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Info cards
                _buildInfoSection('Personal Information', [
                  _InfoRow('Date of Birth',
                      '${patient.dateOfBirth.day}/${patient.dateOfBirth.month}/${patient.dateOfBirth.year}'),
                  _InfoRow('Address', patient.address ?? 'Not provided'),
                  _InfoRow('Insurance ID', patient.insuranceId ?? 'Not provided'),
                ]),
                const SizedBox(height: 16),
                _buildInfoSection('Medical Information', [
                  _InfoRow('Blood Group', patient.bloodGroup ?? 'Unknown'),
                  _InfoRow('Allergies',
                      patient.allergies?.join(', ') ?? 'None reported'),
                ]),
                const SizedBox(height: 16),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_month_rounded),
                        label: const Text('Appointments'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.folder_rounded),
                        label: const Text('Records'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
