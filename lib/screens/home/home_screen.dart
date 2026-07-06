import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../providers/appointment_provider.dart';
import '../../widgets/cards/appointment_card.dart';
import '../../widgets/cards/quick_action_card.dart';
import '../../widgets/charts/health_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AppointmentProvider>().fetchAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),
              const SizedBox(height: 24),
              // Stats cards
              _buildStatsRow(),
              const SizedBox(height: 24),
              // Quick actions
              _buildSectionTitle('Quick Actions'),
              const SizedBox(height: 12),
              _buildQuickActions(),
              const SizedBox(height: 24),
              // Today's appointments
              _buildSectionTitle("Today's Appointments"),
              const SizedBox(height: 12),
              _buildTodayAppointments(),
              const SizedBox(height: 24),
              // Health overview chart
              _buildSectionTitle('Health Overview'),
              const SizedBox(height: 12),
              const HealthChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning 👋',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: AppTheme.borderColor),
              ),
            ),
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 22,
              backgroundColor: AppTheme.primaryLight,
              child: Icon(Icons.person, color: AppTheme.primaryColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.calendar_today_rounded,
            label: 'Appointments',
            value: '12',
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.people_rounded,
            label: 'Patients',
            value: '148',
            color: AppTheme.accentColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.local_hospital_rounded,
            label: 'Doctors',
            value: '24',
            color: AppTheme.secondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        QuickActionCard(
          icon: Icons.add_circle_outline,
          label: 'Book\nAppointment',
          color: const Color(0xFFE8F5E9),
          iconColor: AppTheme.successColor,
          onTap: () {},
        ),
        QuickActionCard(
          icon: Icons.folder_outlined,
          label: 'Medical\nRecords',
          color: const Color(0xFFE3F2FD),
          iconColor: AppTheme.infoColor,
          onTap: () {},
        ),
        QuickActionCard(
          icon: Icons.science_outlined,
          label: 'Lab\nResults',
          color: const Color(0xFFF3E5F5),
          iconColor: AppTheme.secondaryColor,
          onTap: () {},
        ),
        QuickActionCard(
          icon: Icons.receipt_long_outlined,
          label: 'Billing\n& Payments',
          color: const Color(0xFFFFF3E0),
          iconColor: AppTheme.warningColor,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildTodayAppointments() {
    return Consumer<AppointmentProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final appointments = provider.todayAppointments;
        if (appointments.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: const Center(
              child: Column(
                children: [
                  Icon(Icons.event_available_rounded,
                      size: 48, color: AppTheme.textSecondary),
                  SizedBox(height: 8),
                  Text('No appointments today',
                      style: TextStyle(color: AppTheme.textSecondary)),
                ],
              ),
            ),
          );
        }

        return Column(
          children: appointments
              .take(3)
              .map((a) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AppointmentCard(appointment: a),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('See All'),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
