import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_decorations.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool isActive;
  final double blur;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.isActive = false,
    this.blur = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: isActive 
              ? AppDecorations.glassContainerActive 
              : AppDecorations.glassContainer,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
