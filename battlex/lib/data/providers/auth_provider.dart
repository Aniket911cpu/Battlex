import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final authProvider = NotifierProvider<AuthNotifier, bool>(AuthNotifier.new);

class AuthNotifier extends Notifier<bool> {
  @override
  bool build() {
    final box = Hive.box('authBox');
    return box.get('isLoggedIn', defaultValue: false) as bool;
  }

  Future<void> login(String phone) async {
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
