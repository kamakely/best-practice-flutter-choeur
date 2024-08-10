import 'dart:convert';

Member memberFromJson(String str) => Member.fromJson(json.decode(str));

String memberToJson(Member data) => json.encode(data.toJson());

class Member {
  String? id;
  String? firstName;
  String lastName;
  String phone;
  String? email;
  String address;
  String church;
  String group;
  String? remarkMember;
  String voiceId;
  String? profilUrl;

  Member({
    this.id,
    required this.lastName,
    this.firstName,
    required this.phone,
    required this.address,
    required this.church,
    required this.group,
    required this.voiceId,
    this.email,
    this.remarkMember,
    this.profilUrl,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      address: json['address'],
      church: json['church'],
      group: json['group'],
      email: json['email'],
      voiceId: json['voice_id'],
      remarkMember: json['remark_member'],
      profilUrl: json['profil_url'],);

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'address': address,
        'church': church,
        'group': group,
        'email': email,
        'voice_id': voiceId,
        'remark_member': remarkMember,
        'profil_url': profilUrl,
      };
}
