import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'ui/components/buttons/primary_button.dart';
import 'ui/components/badges/live_badge.dart';
import 'ui/components/progress_bar.dart';
import 'ui/components/glass_container.dart';

void main() {
  runApp(
    const ProviderScope(
      child: BattleXApp(),
    ),
  );
}

class BattleXApp extends StatelessWidget {
  const BattleXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BattleX',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const TestThemeScreen(),
    );
  }
}

class TestThemeScreen extends StatelessWidget {
  const TestThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('BattleX UI Test', style: theme.textTheme.titleMedium),
        backgroundColor: theme.colorScheme.surfaceContainerLowest,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Typography', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 16),
            Text('Display Large', style: theme.textTheme.displayLarge),
            Text('Headline Large', style: theme.textTheme.headlineLarge),
            Text('Title Medium', style: theme.textTheme.titleMedium),
            Text('BODY TEXT - Inter', style: theme.textTheme.bodyLarge),
            Text('LABEL - Space Grotesk', style: theme.textTheme.labelLarge),
            Text('₹2,500', style: theme.textTheme.labelLarge?.copyWith(
              fontFamily: 'Space Grotesk', fontSize: 32, fontWeight: FontWeight.bold
            )), // statNumeric

            const SizedBox(height: 32),
            Text('Components', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 16),
            
            PrimaryButton(
              text: 'Enter Match',
              icon: Icons.sports_esports,
              onPressed: () {},
            ),
            
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: LiveBadge(),
            ),

            const SizedBox(height: 16),
            const GlowProgressBar(
              progress: 0.84,
              labelLeft: 'CAPACITY: 84/100',
              labelRight: '16 LEFT',
            ),

            const SizedBox(height: 32),
            Text('Glassmorphism', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 16),
            
            GlassContainer(
              isActive: true,
              child: Column(
                children: [
                  Text('Active Match Card', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text('This uses BackdropFilter and border glows.', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
