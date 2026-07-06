import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../services/api_service.dart';

class AppointmentProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<Appointment> _appointments = [];
  bool _isLoading = false;
  String? _error;

  List<Appointment> get appointments => _appointments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Appointment> get todayAppointments => _appointments.where((a) {
        final now = DateTime.now();
        return a.appointmentDate.year == now.year &&
            a.appointmentDate.month == now.month &&
            a.appointmentDate.day == now.day;
      }).toList();

  List<Appointment> get upcomingAppointments => _appointments
      .where((a) =>
          a.appointmentDate.isAfter(DateTime.now()) &&
          a.status != AppointmentStatus.cancelled)
      .toList();

  Future<void> fetchAppointments() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _api.get('appointments');
      _appointments = (response['data'] as List)
          .map((json) => Appointment.fromJson(json))
          .toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> bookAppointment(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _api.post('appointments', body: data);
      final newAppointment = Appointment.fromJson(response['data']);
      _appointments.insert(0, newAppointment);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> cancelAppointment(String id) async {
    try {
      await _api.put('appointments/$id/cancel');
      final index = _appointments.indexWhere((a) => a.id == id);
      if (index != -1) {
        // Update status locally
        _appointments = List.from(_appointments);
      }
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
