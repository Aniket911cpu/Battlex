import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import '../models/user_model.dart';

final userProvider = NotifierProvider<UserNotifier, UserModel?>(UserNotifier.new);

class UserNotifier extends Notifier<UserModel?> {
  @override
  UserModel? build() {
    final box = Hive.box('userBox');
    final userJsonStr = box.get('currentUser');
    if (userJsonStr != null) {
      try {
        final userJson = jsonDecode(userJsonStr as String);
        return UserModel.fromJson(userJson);
      } catch (_) {}
    }
    // Default mock user
    final defaultUser = UserModel(
      id: 'BX-948291',
      username: 'ShadowNinja',
      phone: '+91 9876543210',
      email: 'player@battlex.pro',
      isKycVerified: true,
      vipTier: 'DIAMOND',
      bgmiId: '51239847192',
      ludoId: 'Shadow_Ludo',
    );
    _saveUser(defaultUser);
    return defaultUser;
  }

  void _saveUser(UserModel user) {
    final box = Hive.box('userBox');
    box.put('currentUser', jsonEncode(user.toJson()));
  }

  void updateUser(UserModel updatedUser) {
    state = updatedUser;
    _saveUser(updatedUser);
  }
}
