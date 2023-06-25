import 'package:clinic/screens/admin/add_staff.dart';
import 'package:clinic/screens/admin/admin_dashboard.dart';
import 'package:clinic/screens/admin/all_appoinments.dart';
import 'package:clinic/screens/admin/delete_satff.dart';
import 'package:clinic/screens/admin/feedback_page.dart';
import 'package:clinic/screens/admin/forgot_password.dart';
import 'package:clinic/screens/admin/patient_list.dart';
import 'package:clinic/screens/admin/staff_list.dart';
import 'package:clinic/screens/admin/supervisor_nav_bar.dart';
import 'package:clinic/screens/drawer_screens/about_us.dart';
import 'package:clinic/screens/drawer_screens/cancel_refund.dart';
import 'package:clinic/screens/drawer_screens/contact_us.dart';
import 'package:clinic/screens/drawer_screens/privacy_policy.dart';
import 'package:clinic/screens/drawer_screens/terms.dart';
import 'package:clinic/screens/intro_screens/staff_login/staff_login.dart';
import 'package:clinic/screens/staff/assigned_task.dart';
import 'package:clinic/screens/staff/completed_task.dart';
import 'package:clinic/screens/staff/staff_dashboard.dart';
import 'package:clinic/screens/staff/update_staff_profile.dart';
import 'package:clinic/screens/supervisor/current_appointments_supervisor.dart';
import 'package:clinic/screens/supervisor/pending_appointments.dart';
import 'package:clinic/screens/supervisor/supervisor_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:clinic/screens/intro_screens/supervisorlogin.dart';
import 'screens/intro_screens/admin.dart';
import 'screens/intro_screens/operator_options/operator_page1.dart';
import 'screens/intro_screens/operator_options/operator_page2.dart';
import 'screens/intro_screens/pateint_login/patient_phone.dart';
import 'screens/intro_screens/splash_screen.dart';
import 'screens/patient/appointment_history.dart';
import 'screens/patient/book_appointment.dart';
import 'screens/patient/current_appointments.dart';
import 'screens/patient/dashborad.dart';
import 'screens/patient/update_profile.dart';

Map<String, Widget Function(BuildContext)> getPages = {
  //-------------I N T R O--------------------

  'splash-screen': (context) => const SplashScreen(),
  'welcome-page1': (context) => const MyWelcomePage1(),
  'welcome-page2': (context) => const MyWelcomePage2(),

  'patient-phone': (context) => const PatientPhone(),

  'staff-login': (context) => const StaffPhone(),

  'supervisor-login': (context) => const MySupervisor(),

  'admin-login': (context) => const AdminLogin(),

  'forgot-password': (context) => const ForgotPassword(),

  // -----------  Patient Operator -------------------

  'current-appointments': (context) => const CurrentAppointments(),
  'appointment-history': (context) => const AppointmentHistory(),
  'update-profile': (context) => const UpdateProfile(),
  'book-appointment': (context) => const BookAppointment(),
  'patient-dashboard': (context) => const PatientDashboard(),

  // ------------ Staff Operator ---------------------
  'staff-dashboard': (context) => const StaffDashboard(),
  'update-staff-profile': (context) => const UpdateStaff(),
  'assigned-task': (context) => const AssignedTask(),
  'completed-task': (context) => const CompletedTask(),

  // ------------ Supervisor Operator ------------------
  'supervisor-dashboard': (context) => const SupervisorDashboard(),
  'pending-appointments': (context) => const PendingAppointments(),
  'current-appointments-supervisor': (context) =>
      const CurrentAppointmentsSupervisor(),
  'add-staff': (context) => const AddStaff(),
  'delete-staff': (context) => const DeleteStaff(),

  // ---------------- Admin Operator -----------------------
  'admin-dashboard': (context) => const AdminDashboard(),
  'supervisor-navbar': (context) => const SupervisorNavBar(),
  'completed-appointments': (context) => const AllAppointments(),
  'patient-list': (context) => const PatientList(),
  'staff-list': (context) => const StaffList(),
  'feedback-page': (context) => const FeedbackPage(),

  //----------------  DRAWER -----------------------------
  'about-us': (context) => const AboutUs(),
  'terms': (context) => const Terms(),
  'privacy-policy': (context) => const PrivacyPolicy(),
  'contact-us': (context) => const Contact(),
  'cancel-refund': (context) => const RefundPolicy(),
};

/*
Navigator.pushReplacementNamed(context, '/newroute');
Navigator.pushNamed(context, '/newroute');
*/