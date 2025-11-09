import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Écran du profil (placeholder)
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Contenu à venir',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.muted,
          ),
        ),
      ),
    );
  }
}
