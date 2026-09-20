import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CyberGridBg extends StatelessWidget {
  final Widget child;

  const CyberGridBg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background color
        Container(color: AppColors.surfaceContainerLowest),
        
        // Glow effects
        Positioned(
          top: -100,
          left: MediaQuery.of(context).size.width / 2 - 150,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer.withValues(alpha: 0.15),
              boxShadow: [
                BoxShadow(color: AppColors.primaryContainer.withValues(alpha: 0.15), blurRadius: 100),
              ],
            ),
          ),
        ),
        
        // Grid pattern
        Positioned.fill(
          child: CustomPaint(
            painter: _GridPainter(),
          ),
        ),
        
        // Content
        child,
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
      
    final dotPaint = Paint()
      ..color = AppColors.primaryContainer.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    const double spacing = 32.0;

    for (double i = 0; i < size.width; i += spacing) {
      for (double j = 0; j < size.height; j += spacing) {
        // Draw crosshairs at intersections
        canvas.drawLine(Offset(i - 2, j), Offset(i + 2, j), paint);
        canvas.drawLine(Offset(i, j - 2), Offset(i, j + 2), paint);
        
        // Occasionally draw an orange dot
        if ((i + j) % 128 == 0) {
          canvas.drawCircle(Offset(i, j), 1.5, dotPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

