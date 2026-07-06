import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../services/api_service.dart';

class PatientProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<Patient> _patients = [];
  Patient? _selectedPatient;
  bool _isLoading = false;
  String? _error;

  List<Patient> get patients => _patients;
  Patient? get selectedPatient => _selectedPatient;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPatients() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _api.get('patients');
      _patients = (response['data'] as List)
          .map((json) => Patient.fromJson(json))
          .toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPatientById(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _api.get('patients/$id');
      _selectedPatient = Patient.fromJson(response['data']);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createPatient(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _api.post('patients', body: data);
      final newPatient = Patient.fromJson(response['data']);
      _patients.insert(0, newPatient);
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

  Future<bool> updatePatient(String id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _api.put('patients/$id', body: data);
      final updated = Patient.fromJson(response['data']);
      final index = _patients.indexWhere((p) => p.id == id);
      if (index != -1) _patients[index] = updated;
      _selectedPatient = updated;
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
}
