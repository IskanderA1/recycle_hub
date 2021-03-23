import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import 'package:recycle_hub/model/map_models.dart/contact_model.dart';
import 'package:recycle_hub/model/map_models.dart/coord.dart';
import 'package:recycle_hub/model/map_models.dart/work_time.dart';

part 'marker.g.dart';

@HiveType(typeId: 1)
class CustMarker {
  @HiveField(0)
  String id;
  @HiveField(1)
  List<AcceptType> acceptTypes;
  @HiveField(2)
  String address;
  @HiveField(3)
  List<Contact> contacts;
  @HiveField(4)
  Coords coords;
  @HiveField(5)
  String description;
  @HiveField(6)
  List<String> images;
  @HiveField(7)
  String name;
  @HiveField(8)
  String paybackType;
  @HiveField(9)
  String receptionType;
  @HiveField(10)
  WorkingTime workTime;
  CustMarker({
    this.id,
    this.acceptTypes,
    this.address,
    this.contacts,
    this.coords,
    this.description,
    this.images,
    this.name,
    this.paybackType,
    this.receptionType,
    this.workTime,
  });

  CustMarker copyWith({
    String id,
    List<AcceptType> acceptTypes,
    String address,
    List<Contact> contacts,
    Coords coords,
    String description,
    List<String> images,
    String name,
    String paybackType,
    String receptionType,
    WorkingTime workTime,
  }) {
    return CustMarker(
      id: id ?? this.id,
      acceptTypes: acceptTypes ?? this.acceptTypes,
      address: address ?? this.address,
      contacts: contacts ?? this.contacts,
      coords: coords ?? this.coords,
      description: description ?? this.description,
      images: images ?? this.images,
      name: name ?? this.name,
      paybackType: paybackType ?? this.paybackType,
      receptionType: receptionType ?? this.receptionType,
      workTime: workTime ?? this.workTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'acceptTypes': acceptTypes?.map((x) => x?.toMap())?.toList(),
      'address': address,
      'contacts': contacts?.map((x) => x?.toMap())?.toList(),
      'coords': coords?.toMap(),
      'description': description,
      'images': images,
      'name': name,
      'paybackType': paybackType,
      'receptionType': receptionType,
      'workTime': workTime?.toMap(),
    };
  }

  factory CustMarker.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CustMarker(
      id: map['_id'],
      acceptTypes: List<AcceptType>.from(
          map['accept_types']?.map((x) => AcceptType.fromMap(x))),
      address: map['address'],
      contacts:
          List<Contact>.from(map['contacts']?.map((x) => Contact.fromMap(x))),
      coords: Coords.fromMap(map['coords']),
      description: map['description'],
      images: List<String>.from(map['images']),
      name: map['name'],
      paybackType: map['payback_type'],
      receptionType: map['reception_type'],
      workTime: map['work_time'] != null ? WorkingTime.fromMap(map['work_time']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustMarker.fromJson(String source) =>
      CustMarker.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustMarker(id: $id, acceptTypes: $acceptTypes, address: $address, contacts: $contacts, coords: $coords, description: $description, images: $images, name: $name, paybackType: $paybackType, receptionType: $receptionType, workTime: $workTime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CustMarker &&
        o.id == id &&
        listEquals(o.acceptTypes, acceptTypes) &&
        o.address == address &&
        listEquals(o.contacts, contacts) &&
        o.coords == coords &&
        o.description == description &&
        listEquals(o.images, images) &&
        o.name == name &&
        o.paybackType == paybackType &&
        o.receptionType == receptionType &&
        o.workTime == workTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        acceptTypes.hashCode ^
        address.hashCode ^
        contacts.hashCode ^
        coords.hashCode ^
        description.hashCode ^
        images.hashCode ^
        name.hashCode ^
        paybackType.hashCode ^
        receptionType.hashCode ^
        workTime.hashCode;
  }
}
