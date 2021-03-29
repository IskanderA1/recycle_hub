// To parse this JSON data, do
//
//     final invite = inviteFromMap(jsonString);

import 'dart:convert';

Invite inviteFromMap(String str) => Invite.fromMap(json.decode(str));

String inviteToMap(Invite data) => json.encode(data.toMap());

class Invite {
    Invite({
        this.id,
        this.sender,
        this.code,
        this.isActive,
        this.ammount,
    });

    Id id;
    Id sender;
    int code;
    bool isActive;
    int ammount;

    factory Invite.fromMap(Map<String, dynamic> json) => Invite(
        id: Id.fromMap(json["_id"]),
        sender: Id.fromMap(json["sender"]),
        code: json["code"],
        isActive: json["is_active"],
        ammount: json["ammount"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id.toMap(),
        "sender": sender.toMap(),
        "code": code,
        "is_active": isActive,
        "ammount": ammount,
    };
}

class Id {
    Id({
        this.oid,
    });

    String oid;

    factory Id.fromMap(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
    );

    Map<String, dynamic> toMap() => {
        "\u0024oid": oid,
    };
}
