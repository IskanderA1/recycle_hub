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
    this.acceptTypesNames,
    this.acceptTypes,
    this.coords,
    this.description,
    this.getBonus,
    this.images,
    this.externalImages,
    this.approveStatus,
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
  List<String> acceptTypesNames;
  @HiveField(10)
  List<String> acceptTypes;
  @HiveField(11)
  List<double> coords;
  @HiveField(12)
  String description;
  @HiveField(13)
  bool getBonus;
  @HiveField(14)
  List<dynamic> images;
  @HiveField(15)
  List<String> externalImages;
  @HiveField(16)
  String approveStatus;

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
    List<String> acceptTypesNames,
    List<String> acceptTypes,
    List<double> coords,
    String description,
    bool getBonus,
    List<dynamic> images,
    List<String> externalImages,
    String approveStatus,
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
        acceptTypesNames: acceptTypesNames ?? this.acceptTypesNames,
        acceptTypes: acceptTypes ?? this.acceptTypes,
        coords: coords ?? this.coords,
        description: description ?? this.description,
        getBonus: getBonus ?? this.getBonus,
        images: images ?? this.images,
        externalImages: externalImages ?? this.externalImages,
        approveStatus: approveStatus ?? this.approveStatus,
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
        acceptTypesNames: json["accept_types_names"] == null
            ? null
            : List<String>.from(json["accept_types_names"].map((x) => x)),
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
            : List<dynamic>.from(json["images"].map((x) => x)),
        externalImages: json["external_images"] == null
            ? null
            : List<String>.from(json["external_images"].map((x) => x)),
        approveStatus:
            json["approve_status"] == null ? null : json["approve_status"],
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
        "accept_types_names": acceptTypesNames == null
            ? null
            : List<dynamic>.from(acceptTypesNames.map((x) => x)),
        "accept_types": acceptTypes == null
            ? null
            : List<dynamic>.from(acceptTypes.map((x) => x)),
        "coords":
            coords == null ? null : List<dynamic>.from(coords.map((x) => x)),
        "description": description == null ? null : description,
        "getBonus": getBonus == null ? null : getBonus,
        "images":
            images == null ? null : List<dynamic>.from(images.map((x) => x)),
        "external_images": externalImages == null
            ? null
            : List<dynamic>.from(externalImages.map((x) => x)),
        "approve_status": approveStatus == null ? null : approveStatus,
      };
}
