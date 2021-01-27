import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import 'package:recycle_hub/model/map_models.dart/coord.dart';
import 'package:recycle_hub/model/map_models.dart/work_time.dart';

class CustMarker {
  String id;
  List<AcceptType> acceptTypes;
  String address;
  String contacts;
  Coords coords;
  String description;
  List<String> images;
  String name;
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
    this.workTime,
  });

  CustMarker copyWith({
    String id,
    List<AcceptType> acceptTypes,
    String address,
    String contacts,
    Coords coords,
    String description,
    List<String> images,
    String name,
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
      workTime: workTime ?? this.workTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'accept_types': acceptTypes?.map((x) => x?.toMap())?.toList(),
      'address': address,
      'contacts': contacts,
      'coords': coords?.toMap(),
      'description': description,
      'images': images,
      'name': name,
      'work_time': workTime?.toMap(),
    };
  }

  CustMarker.fromMap(Map<String, dynamic> map) {
    id = map['_id'];
    acceptTypes = List<AcceptType>.from(
        map['accept_types']?.map((x) => AcceptType.fromMap(x)));
    address = map['address'];
    contacts = map['contacts'];
    coords = Coords.fromMap(map['coords']);
    description = map['description'];
    images = List<String>.from(map['images']);
    name = map['name'];
    workTime = WorkingTime.fromMap(map['work_time']);
  }

  String toJson() => json.encode(toMap());

  factory CustMarker.fromJson(String source) =>
      CustMarker.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Marker(id: $id, acceptTypes: $acceptTypes, address: $address, contacts: $contacts, coords: $coords, description: $description, images: $images, name: $name, workTime: $workTime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CustMarker &&
        o.id == id &&
        listEquals(o.acceptTypes, acceptTypes) &&
        o.address == address &&
        o.contacts == contacts &&
        o.coords == coords &&
        o.description == description &&
        listEquals(o.images, images) &&
        o.name == name &&
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
        workTime.hashCode;
  }
}
