import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/patients/patients_list_screen.dart';
import '../screens/patients/patient_detail_screen.dart';
import '../screens/appointments/appointments_screen.dart';
import '../screens/appointments/book_appointment_screen.dart';
import '../screens/doctors/doctors_screen.dart';
import '../screens/profile/profile_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/patients',
            builder: (context, state) => const PatientsListScreen(),
          ),
          GoRoute(
            path: '/patients/:id',
            builder: (context, state) => PatientDetailScreen(
              patientId: state.pathParameters['id']!,
            ),
          ),
          GoRoute(
            path: '/appointments',
            builder: (context, state) => const AppointmentsScreen(),
          ),
          GoRoute(
            path: '/appointments/book',
            builder: (context, state) => const BookAppointmentScreen(),
          ),
          GoRoute(
            path: '/doctors',
            builder: (context, state) => const DoctorsScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}

class MainShell extends StatefulWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final _routes = ['/home', '/patients', '/appointments', '/doctors', '/profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          context.go(_routes[index]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'Patients'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital_rounded), label: 'Doctors'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
