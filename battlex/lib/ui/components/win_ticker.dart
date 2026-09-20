import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class WinTicker extends StatefulWidget {
  const WinTicker({super.key});

  @override
  State<WinTicker> createState() => _WinTickerState();
}

class _WinTickerState extends State<WinTicker> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  final List<String> _wins = [
    "@ShadowNinja just cashed out ₹1,500 in BGMI Duo",
    "@ViperXx won ₹500 in Ludo Challenge",
    "@GhostRecon placed #1 in Free Fire Squads",
    "@NoobMaster69 withdrew ₹2,000 to UPI",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      color: AppColors.primaryContainer.withOpacity(0.1),
      child: Row(
        children: [
          // Live Dot
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.surfaceContainerLowest, Colors.transparent],
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGlow.withOpacity(0.8),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text('LIVE', style: AppTextStyles.labelSm.copyWith(color: AppColors.primaryContainer)),
              ],
            ),
          ),
          
          // Marquee
          Expanded(
            child: ClipRect(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FractionalTranslation(
                    translation: Offset(1.0 - (_controller.value * 2), 0.0),
                    child: child,
                  );
                },
                child: Row(
                  children: _wins.map((win) => Padding(
                    padding: const EdgeInsets.only(right: 32.0),
                    child: Text(
                      win,
                      style: AppTextStyles.bodySm.copyWith(color: AppColors.secondary),
                    ),
                  )).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
