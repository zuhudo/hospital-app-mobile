import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../providers/patient_provider.dart';
import '../../widgets/cards/patient_card.dart';
import '../../widgets/common/custom_text_field.dart';

class PatientsListScreen extends StatefulWidget {
  const PatientsListScreen({super.key});

  @override
  State<PatientsListScreen> createState() => _PatientsListScreenState();
}

class _PatientsListScreenState extends State<PatientsListScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PatientProvider>().fetchPatients();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomTextField(
              controller: _searchController,
              label: '',
              hint: 'Search patients...',
              prefixIcon: Icons.search_rounded,
              onChanged: (value) {
                // TODO: implement search
              },
            ),
          ),
          // Patients list
          Expanded(
            child: Consumer<PatientProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 48, color: AppTheme.errorColor),
                        const SizedBox(height: 16),
                        Text(provider.error!),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => provider.fetchPatients(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (provider.patients.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline_rounded,
                            size: 64, color: AppTheme.textSecondary),
                        SizedBox(height: 16),
                        Text('No patients found',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppTheme.textSecondary,
                            )),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: provider.patients.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: PatientCard(patient: provider.patients[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: navigate to add patient
        },
        icon: const Icon(Icons.person_add_rounded),
        label: const Text('Add Patient'),
      ),
    );
  }
}
