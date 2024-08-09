import 'dart:convert';

Role voiceFromJson(String str) => Role.fromJson(json.decode(str));

String voiceToJson(Role data) => json.encode(data.toJson());

class Role {
    String id;
    String name;

    Role({
        required this.id,
        required this.name,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json['id'],
        name: json['name'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
    };
}
