import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Boutons d'action pour le deck swipable
class SwipeButtons extends StatelessWidget {
  final VoidCallback onReject;
  final VoidCallback onLike;
  final VoidCallback onMatch;

  const SwipeButtons({
    super.key,
    required this.onReject,
    required this.onLike,
    required this.onMatch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Bouton Refuser
        _ActionButton(
          icon: Icons.close,
          color: Colors.red,
          onPressed: onReject,
          label: 'Refuser',
        ),
        
        const SizedBox(width: 20),
        
        // Bouton Match (Super like)
        _ActionButton(
          icon: Icons.local_fire_department,
          color: Colors.blue,
          onPressed: onMatch,
          label: 'Match',
          size: 70,
        ),
        
        const SizedBox(width: 20),
        
        // Bouton Like
        _ActionButton(
          icon: Icons.favorite,
          color: AppColors.primary,
          onPressed: onLike,
          label: 'Like',
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final String label;
  final double size;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onPressed,
    required this.label,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(size / 2),
              child: Icon(
                icon,
                color: color,
                size: size * 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
