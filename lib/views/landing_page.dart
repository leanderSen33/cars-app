import 'package:cars_app/services/database/firestore.dart';
import 'package:cars_app/views/login_view.dart';

import 'package:cars_app/views/vehicle_inspections_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth/auth_service.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _auth = AuthService.firebase();
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return const LogInView(title: 'title');
          }
          return Provider<Firestore>(
            create: (_) => Firestore(uid: user.uid),
            child: const VehicleInspectionOverviewView(),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
