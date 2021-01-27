import 'dart:convert';

import 'package:recycle_hub/model/working_days_model.dart';

class MarkerModel {
  String name;
  String description;
  String partnerID;
  String partnerName;
  String markType;
  WorkingDaysModel workTime;
  MarkerModel({
    this.name,
    this.description,
    this.partnerID,
    this.partnerName,
    this.markType,
    this.workTime,
  });

  MarkerModel copyWith({
    String name,
    String description,
    String partnerID,
    String partnerName,
    String markType,
    WorkingDaysModel workTime,
  }) {
    return MarkerModel(
      name: name ?? this.name,
      description: description ?? this.description,
      partnerID: partnerID ?? this.partnerID,
      partnerName: partnerName ?? this.partnerName,
      markType: markType ?? this.markType,
      workTime: workTime ?? this.workTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'partnerID': partnerID,
      'partnerName': partnerName,
      'markType': markType,
      'workTime': workTime?.toMap(),
    };
  }

  factory MarkerModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MarkerModel(
      name: map['name'],
      description: map['description'],
      partnerID: map['partnerID'],
      partnerName: map['partnerName'],
      markType: map['markType'],
      workTime: WorkingDaysModel.fromMap(map['workTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MarkerModel.fromJson(String source) =>
      MarkerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MarkerModel(name: $name, description: $description, partnerID: $partnerID, partnerName: $partnerName, markType: $markType, workTime: $workTime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MarkerModel &&
        o.name == name &&
        o.description == description &&
        o.partnerID == partnerID &&
        o.partnerName == partnerName &&
        o.markType == markType &&
        o.workTime == workTime;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        partnerID.hashCode ^
        partnerName.hashCode ^
        markType.hashCode ^
        workTime.hashCode;
  }
}
