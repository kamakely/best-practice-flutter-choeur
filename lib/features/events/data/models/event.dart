import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
    String id;
    String name;
    DateTime date;

    Event({
        required this.id,
        required this.name,
        required this.date
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json['id'],
        name: json['name'],
        date: json['date']
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date,
    };
}
