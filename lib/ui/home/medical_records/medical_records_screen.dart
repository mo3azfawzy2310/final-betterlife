import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_life/ui/logic/medical_records/medical_records_cubit.dart';
import 'package:better_life/models/medical_record_model.dart';
import 'package:better_life/models/radiation_model.dart';
import 'package:better_life/core/services/user_service.dart';

class MedicalRecordsScreen extends StatefulWidget {
  static const String routeName = 'medical-records-screen';

  const MedicalRecordsScreen({super.key});

  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? currentPatientId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadCurrentUser();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentUser() async {
    final user = await UserService.getCurrentUser();
    if (!mounted) return;
    
    if (user?.patientId != null) {
      setState(() {
        currentPatientId = user!.patientId.toString();
      });
      if (currentPatientId != null) {
        context.read<MedicalRecordsCubit>().getAllRecords(currentPatientId!);
      }
    } else {
      // Use default patient ID for demo
      setState(() {
        currentPatientId = '1';
      });
      context.read<MedicalRecordsCubit>().getAllRecords('1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Records'),
        backgroundColor: const Color(0xFF199A8E),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Medical Records'),
            Tab(text: 'Radiation Records'),
          ],
        ),
      ),
      body: BlocConsumer<MedicalRecordsCubit, MedicalRecordsState>(
        listener: (context, state) {
          if (state is AllRecordsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is AllRecordsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AllRecordsLoaded) {
            return TabBarView(
              controller: _tabController,
              children: [
                _buildMedicalRecordsTab(state.medicalRecords),
                _buildRadiationRecordsTab(state.radiationRecords),
              ],
            );
          } else if (state is AllRecordsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading records',
                    style: TextStyle(fontSize: 18, color: Colors.red[700]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (currentPatientId != null) {
                        context.read<MedicalRecordsCubit>().getAllRecords(currentPatientId!);
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text('No records to display'),
          );
        },
      ),
    );
  }

  Widget _buildMedicalRecordsTab(List<MedicalRecordModel> records) {
    if (records.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.medical_services_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No medical records found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return MedicalRecordCard(record: record);
      },
    );
  }

  Widget _buildRadiationRecordsTab(List<RadiationModel> records) {
    if (records.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.science_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No radiation records found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return RadiationRecordCard(record: record);
      },
    );
  }
}

class MedicalRecordCard extends StatelessWidget {
  final MedicalRecordModel record;

  const MedicalRecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: ExpansionTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF199A8E),
          child: Icon(Icons.medical_services, color: Colors.white),
        ),
        title: Text(
          record.title ?? 'Medical Record',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          record.date ?? 'Unknown date',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (record.description != null) ...[
                  const Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(record.description!),
                  const SizedBox(height: 16),
                ],
                if (record.doctorName != null) ...[
                  _buildInfoRow('Doctor:', record.doctorName!),
                ],
                if (record.hospital != null) ...[
                  _buildInfoRow('Hospital:', record.hospital!),
                ],
                if (record.type != null) ...[
                  _buildInfoRow('Type:', record.type!),
                ],
                if (record.fileUrl != null) ...[
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement file download/view
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('File download not implemented yet')),
                      );
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Download File'),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class RadiationRecordCard extends StatelessWidget {
  final RadiationModel record;

  const RadiationRecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: ExpansionTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.orange,
          child: Icon(Icons.science, color: Colors.white),
        ),
        title: Text(
          record.type ?? 'Radiation Record',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          record.date ?? 'Unknown date',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (record.description != null) ...[
                  const Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(record.description!),
                  const SizedBox(height: 16),
                ],
                if (record.doctorName != null) ...[
                  _buildInfoRow('Doctor:', record.doctorName!),
                ],
                if (record.hospital != null) ...[
                  _buildInfoRow('Hospital:', record.hospital!),
                ],
                if (record.result != null) ...[
                  _buildInfoRow('Result:', record.result!),
                ],
                if (record.fileUrl != null) ...[
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement file download/view
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('File download not implemented yet')),
                      );
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Download File'),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
} 