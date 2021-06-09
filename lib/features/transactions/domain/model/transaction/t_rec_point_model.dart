/* import 'package:hive/hive.dart';
import 'package:recycle_hub/features/transactions/domain/model/transaction/t_contact_model.dart';
import 'package:recycle_hub/features/transactions/domain/model/transaction/t_coords_model.dart';
import 't_working_time_model.dart';


class To {
    To({
        this.id,
        this.acceptTypes,
        this.address,
        this.contacts,
        this.coords,
        this.description,
        this.images,
        this.name,
        this.partner,
        this.paybackType,
        this.receptionType,
        this.workTime,
    });

    String id;
    List<String> acceptTypes;
    String address;
    List<TContact> contacts;
    TCoords coords;
    String description;
    List<String> images;
    String name;
    String partner;
    String paybackType;
    String receptionType;
    WorkTime workTime;

    factory To.fromJson(Map<String, dynamic> json) => To(
        id: json["_id"],
        acceptTypes: List<String>.from(json["accept_types"].map((x) => x)),
        address: json["address"],
        contacts: List<TContact>.from(json["contacts"].map((x) => TContact.fromJson(x))),
        coords: TCoords.fromJson(json["coords"]),
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        name: json["name"],
        partner: json["partner"],
        paybackType: json["payback_type"],
        receptionType: json["reception_type"],
        workTime: WorkTime.fromJson(json["work_time"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "accept_types": List<dynamic>.from(acceptTypes.map((x) => x)),
        "address": address,
        "contacts": List<dynamic>.from(contacts.map((x) => x.toJson())),
        "coords": coords.toJson(),
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "name": name,
        "partner": partner,
        "payback_type": paybackType,
        "reception_type": receptionType,
        "work_time": workTime.toJson(),
    };
} */