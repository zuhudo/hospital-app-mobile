import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../providers/appointment_provider.dart';
import '../../widgets/cards/appointment_card.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Future.microtask(() {
      context.read<AppointmentProvider>().fetchAppointments();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.textSecondary,
          indicatorColor: AppTheme.primaryColor,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: Consumer<AppointmentProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildAppointmentList(provider.upcomingAppointments),
              _buildAppointmentList(provider.appointments
                  .where((a) => a.status.name == 'completed')
                  .toList()),
              _buildAppointmentList(provider.appointments
                  .where((a) => a.status.name == 'cancelled')
                  .toList()),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/appointments/book'),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Book Appointment'),
      ),
    );
  }

  Widget _buildAppointmentList(List appointments) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy_rounded,
                size: 64, color: AppTheme.textSecondary.withOpacity(0.5)),
            const SizedBox(height: 16),
            const Text('No appointments',
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 16)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppointmentCard(appointment: appointments[index]),
        );
      },
    );
  }
}
