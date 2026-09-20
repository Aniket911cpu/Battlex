import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/cyber_grid_bg.dart';
import '../../components/buttons/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'DOMINATE THE ARENA',
      'subtitle': 'Compete in high-stakes tournaments for BGMI, Free Fire, and more. Prove your skills and rise to the top.',
    },
    {
      'title': 'WIN REAL CASH',
      'subtitle': 'Turn your gaming passion into real earnings. Instant withdrawals and secure escrow for every match.',
    },
    {
      'title': 'BUILD YOUR LEGACY',
      'subtitle': 'Climb the global leaderboard, earn VIP badges, and become an esports legend in the BattleX community.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CyberGridBg(
        child: SafeArea(
          child: Column(
            children: [
              // Skip Button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => context.go('/login'),
                  child: Text(
                    'SKIP',
                    style: AppTextStyles.labelMd.copyWith(color: AppColors.secondary),
                  ),
                ),
              ),
              
              // Slides
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Placeholder for Art
                          Container(
                            height: 240,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerHigh,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryGlow.withOpacity(0.2),
                                  blurRadius: 40,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.sports_esports, size: 80, color: AppColors.primaryContainer),
                          ),
                          const SizedBox(height: 48),
                          Text(
                            _slides[index]['title']!,
                            style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.onSurface),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _slides[index]['subtitle']!,
                            style: AppTextStyles.bodyLg.copyWith(color: AppColors.secondary),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              // Bottom Controls
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Dot Indicators
                    Row(
                      children: List.generate(
                        _slides.length,
                        (index) => Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: _currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index ? AppColors.primaryContainer : AppColors.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    
                    // Next/Start Button
                    PrimaryButton(
                      text: _currentPage == _slides.length - 1 ? 'START' : 'NEXT',
                      icon: _currentPage == _slides.length - 1 ? Icons.check : Icons.arrow_forward,
                      onPressed: _nextPage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
