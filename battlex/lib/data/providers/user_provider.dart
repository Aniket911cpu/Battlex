import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null) {
    _loadUser();
  }

  void _loadUser() {
    final box = Hive.box('userBox');
    final userJsonStr = box.get('currentUser');
    if (userJsonStr != null) {
      final userJson = jsonDecode(userJsonStr);
      state = UserModel.fromJson(userJson);
    } else {
      // Default Mock User
      state = UserModel(
        id: 'BX-948291',
        username: 'ShadowNinja',
        phone: '+91 9876543210',
        email: 'player@battlex.pro',
        isKycVerified: true,
        vipTier: 'DIAMOND',
        bgmiId: '51239847192',
        ludoId: 'Shadow_Ludo',
      );
      _saveUser(state!);
    }
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

