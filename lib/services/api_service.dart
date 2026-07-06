import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/constants.dart';
import 'storage_service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final String _baseUrl = AppConstants.apiBaseUrl;

  Map<String, String> get _headers {
    final token = StorageService.getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? queryParams}) async {
    final uri = Uri.parse('$_baseUrl/$endpoint').replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: _headers);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.post(uri, headers: _headers, body: jsonEncode(body));
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.put(uri, headers: _headers, body: jsonEncode(body));
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    final uri = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.delete(uri, headers: _headers);
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: body['message'] ?? 'An error occurred',
      );
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException($statusCode): $message';
}
