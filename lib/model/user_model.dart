import 'dart:convert';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel{

  @HiveField(0)
  String id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String surname = "";

  @HiveField(3)
  String name;

  @HiveField(4)
  String password;

  @HiveField(5)
  String image;

  @HiveField(6)
  bool confirmed;

  @HiveField(7)
  int ecoCoins;

  @HiveField(8)
  int refCode;

  @HiveField(9)
  String qrCode;

  @HiveField(10)
  String token;
  UserModel({
    this.id,
    this.username,
    this.surname,
    this.name,
    this.password,
    this.image,
    this.confirmed,
    this.ecoCoins,
    this.refCode,
    this.qrCode,
    this.token,
  });
  UserModel copyWith({
    String id,
    String username,
    String surname,
    String name,
    String password,
    String image,
    bool confirmed,
    double ecoCoins,
    int refCode,
    String qrCode,
    String token,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      surname: surname ?? this.surname,
      name: name ?? this.name,
      password: password ?? this.password,
      image: image ?? this.image,
      confirmed: confirmed ?? this.confirmed,
      ecoCoins: ecoCoins ?? this.ecoCoins,
      refCode: refCode ?? this.refCode,
      qrCode: qrCode ?? this.qrCode,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'surname': surname,
      'name': name,
      'password': password,
      'image': image,
      'confirmed': confirmed,
      'ecoCoins': ecoCoins,
      'refCode': refCode,
      'qrCode': qrCode,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      id: map["_id"]["! @ # \$ & * ~oid"],
      username: map['username'],
      surname: "",
      name: map['name'],
      password: map['password'],
      image: map['image'],
      confirmed: map['confirmed'],
      ecoCoins: map['eco_coins'],
      refCode: map['refCode'],
      qrCode: map['qrcode'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, surname: $surname, name: $name, password: $password, image: $image, confirmed: $confirmed, ecoCoins: $ecoCoins, refCode: $refCode, qrCode: $qrCode, token: $token)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel &&
        o.id == id &&
        o.username == username &&
        o.surname == surname &&
        o.name == name &&
        o.password == password &&
        o.image == image &&
        o.confirmed == confirmed &&
        o.ecoCoins == ecoCoins &&
        o.refCode == refCode &&
        o.qrCode == qrCode &&
        o.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        surname.hashCode ^
        name.hashCode ^
        password.hashCode ^
        image.hashCode ^
        confirmed.hashCode ^
        ecoCoins.hashCode ^
        refCode.hashCode ^
        qrCode.hashCode ^
        token.hashCode;
  }
  
}
