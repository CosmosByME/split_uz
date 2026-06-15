class UserModel {
  final String uid; // Firebase Auth UID — primary key
  final String phone; // +998XXXXXXXXX — indexed in Firestore
  final String displayName; // set during onboarding
  final String? telegramId; // nullable — linked after bot interaction
  final String? avatarUrl; // nullable — optional profile photo
  final DateTime createdAt; // account creation timestamp
  final DateTime lastActiveAt; // for future analytics, not v1 UI
  final List<String> friendUids; // uids of registered friends
  final List<String> guestRefs; // phone numbers of guest friends

  const UserModel({
    required this.uid,
    required this.phone,
    required this.displayName,
    this.telegramId,
    this.avatarUrl,
    required this.createdAt,
    required this.lastActiveAt,
    required this.friendUids,
    required this.guestRefs,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      phone: json['phone'],
      displayName: json['displayName'],
      telegramId: json['telegramId'],
      avatarUrl: json['avatarUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      lastActiveAt: DateTime.parse(json['lastActiveAt']),
      friendUids: List<String>.from(json['friendUids'] ?? []),
      guestRefs: List<String>.from(json['guestRefs'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phone': phone,
      'displayName': displayName,
      'telegramId': telegramId,
      'avatarUrl': avatarUrl,
      'createdAt': createdAt.toIso8601String(),
      'lastActiveAt': lastActiveAt.toIso8601String(),
      'friendUids': friendUids,
      'guestRefs': guestRefs,
    };
  }
}
