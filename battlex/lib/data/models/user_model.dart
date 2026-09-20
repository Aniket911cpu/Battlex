class UserModel {
  final String id;
  final String username;
  final String phone;
  final String? email;
  final bool isKycVerified;
  final String vipTier; // 'NONE', 'DIAMOND', 'CONQUEROR'
  final String? bgmiId;
  final String? freeFireId;
  final String? ludoId;

  UserModel({
    required this.id,
    required this.username,
    required this.phone,
    this.email,
    this.isKycVerified = false,
    this.vipTier = 'NONE',
    this.bgmiId,
    this.freeFireId,
    this.ludoId,
  });

  UserModel copyWith({
    String? username,
    String? email,
    bool? isKycVerified,
    String? vipTier,
    String? bgmiId,
    String? freeFireId,
    String? ludoId,
  }) {
    return UserModel(
      id: id,
      username: username ?? this.username,
      phone: phone,
      email: email ?? this.email,
      isKycVerified: isKycVerified ?? this.isKycVerified,
      vipTier: vipTier ?? this.vipTier,
      bgmiId: bgmiId ?? this.bgmiId,
      freeFireId: freeFireId ?? this.freeFireId,
      ludoId: ludoId ?? this.ludoId,
    );
  }

  // Simplified fromJson / toJson for local mock
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      isKycVerified: json['isKycVerified'] ?? false,
      vipTier: json['vipTier'] ?? 'NONE',
      bgmiId: json['bgmiId'],
      freeFireId: json['freeFireId'],
      ludoId: json['ludoId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phone': phone,
      'email': email,
      'isKycVerified': isKycVerified,
      'vipTier': vipTier,
      'bgmiId': bgmiId,
      'freeFireId': freeFireId,
      'ludoId': ludoId,
    };
  }
}

