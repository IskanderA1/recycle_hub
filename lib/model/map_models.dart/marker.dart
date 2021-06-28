import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:recycle_hub/model/map_models.dart/work_time.dart';

part 'marker.g.dart';

@HiveType(typeId: 1)
class CustMarker {
  CustMarker({
    this.id,
    this.name,
    this.partner,
    this.partnerName,
    this.paybackType,
    this.receptionType,
    this.workTime,
    this.address,
    this.contacts,
    this.acceptTypes,
    this.coords,
    this.description,
    this.getBonus,
    this.images,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String partner;
  @HiveField(3)
  String partnerName;
  @HiveField(4)
  String paybackType;
  @HiveField(5)
  String receptionType;
  @HiveField(6)
  WorkingTime workTime;
  @HiveField(7)
  String address;
  @HiveField(8)
  List<String> contacts;
  @HiveField(9)
  List<String> acceptTypes;
  @HiveField(10)
  List<double> coords;
  @HiveField(11)
  String description;
  @HiveField(12)
  bool getBonus;
  @HiveField(13)
  List<String> images;

  CustMarker copyWith({
    String id,
    String name,
    String partner,
    String partnerName,
    String paybackType,
    String receptionType,
    WorkingTime workTime,
    String address,
    List<String> contacts,
    List<String> acceptTypes,
    List<double> coords,
    String description,
    bool getBonus,
    List<String> images,
  }) =>
      CustMarker(
        id: id ?? this.id,
        name: name ?? this.name,
        partner: partner ?? this.partner,
        partnerName: partnerName ?? this.partnerName,
        paybackType: paybackType ?? this.paybackType,
        receptionType: receptionType ?? this.receptionType,
        workTime: workTime ?? this.workTime,
        address: address ?? this.address,
        contacts: contacts ?? this.contacts,
        acceptTypes: acceptTypes ?? this.acceptTypes,
        coords: coords ?? this.coords,
        description: description ?? this.description,
        getBonus: getBonus ?? this.getBonus,
        images: images ?? this.images,
      );

  factory CustMarker.fromJson(String str) =>
      CustMarker.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustMarker.fromMap(Map<String, dynamic> json) => CustMarker(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        partner: json["partner"] == null ? null : json["partner"],
        partnerName: json["partner_name"] == null ? null : json["partner_name"],
        paybackType: json["payback_type"] == null ? null : json["payback_type"],
        receptionType:
            json["reception_type"] == null ? null : json["reception_type"],
        workTime: json["work_time"] == null
            ? null
            : WorkingTime.fromMap(json["work_time"]),
        address: json["address"] == null ? null : json["address"],
        contacts: json["contacts"] == null
            ? null
            : List<String>.from(json["contacts"].map((x) => x)),
        acceptTypes: json["accept_types"] == null
            ? null
            : List<String>.from(json["accept_types"].map((x) => x)),
        coords: json["coords"] == null
            ? null
            : List<double>.from(json["coords"].map((x) => x.toDouble())),
        description: json["description"] == null ? null : json["description"],
        getBonus: json["getBonus"] == null ? null : json["getBonus"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "partner": partner == null ? null : partner,
        "partner_name": partnerName == null ? null : partnerName,
        "payback_type": paybackType == null ? null : paybackType,
        "reception_type": receptionType == null ? null : receptionType,
        "work_time": workTime == null ? null : workTime.toMap(),
        "address": address == null ? null : address,
        "contacts": contacts == null
            ? null
            : List<dynamic>.from(contacts.map((x) => x)),
        "accept_types": acceptTypes == null
            ? null
            : List<dynamic>.from(acceptTypes.map((x) => x)),
        "coords":
            coords == null ? null : List<dynamic>.from(coords.map((x) => x)),
        "description": description == null ? null : description,
        "getBonus": getBonus == null ? null : getBonus,
        "images":
            images == null ? null : List<dynamic>.from(images.map((x) => x)),
      };
}

/*@HiveType(typeId: 1)
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
*/
