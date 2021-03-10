import 'dart:convert';

import 'package:hive/hive.dart';
part 'contact_model.g.dart';
@HiveType(typeId: 3)
class Contact {
  @HiveField(0)
  String name;
  @HiveField(1)
  String phone;
  Contact({
    this.name,
    this.phone,
  });

  Contact copyWith({
    String name,
    String phone,
  }) {
    return Contact(
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Contact(
      name: map['name'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source));

  @override
  String toString() => 'Contact(name: $name, phone: $phone)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Contact && o.name == name && o.phone == phone;
  }

  @override
  int get hashCode => name.hashCode ^ phone.hashCode;
}
