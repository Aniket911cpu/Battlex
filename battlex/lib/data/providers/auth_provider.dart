import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false) {
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    final box = Hive.box('authBox');
    final isLoggedIn = box.get('isLoggedIn', defaultValue: false);
    state = isLoggedIn;
  }

  Future<void> login(String phone) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    final box = Hive.box('authBox');
    await box.put('isLoggedIn', true);
    await box.put('phone', phone);
    state = true;
  }

  Future<void> logout() async {
    final box = Hive.box('authBox');
    await box.put('isLoggedIn', false);
    await box.delete('phone');
    state = false;
  }
}
