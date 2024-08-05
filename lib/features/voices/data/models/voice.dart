// To parse this JSON data, do
//
//     final voice = voiceFromJson(jsonString);

import 'dart:convert';

Voice voiceFromJson(String str) => Voice.fromJson(json.decode(str));

String voiceToJson(Voice data) => json.encode(data.toJson());

class Voice {
    String id;
    String name;

    Voice({
        required this.id,
        required this.name,
    });

    factory Voice.fromJson(Map<String, dynamic> json) => Voice(
        id: json['id'],
        name: json['name'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
    };
}
