import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:battlex/main.dart';

void main() {
  setUpAll(() async {
    await Hive.initFlutter();
    await Hive.openBox('authBox');
    await Hive.openBox('userBox');
    await Hive.openBox('walletBox');
  });

  tearDownAll(() async {
    await Hive.close();
  });

  testWidgets('BattleX app launches without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: BattleXApp()));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    // App should start at SplashScreen - verify it renders
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
