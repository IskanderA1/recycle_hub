

class From {
    From({
        this.id,
        this.code,
        this.confirmed,
        this.ecoCoins,
        this.image,
        this.name,
        this.password,
        this.qrcode,
        this.surname,
        this.token,
        this.username,
    });

    String id;
    int code;
    bool confirmed;
    int ecoCoins;
    String image;
    String name;
    String password;
    String qrcode;
    String surname;
    String token;
    String username;

    factory From.fromJson(Map<String, dynamic> json) => From(
        id: json["_id"],
        code: json["code"],
        confirmed: json["confirmed"],
        ecoCoins: json["eco_coins"],
        image: json["image"],
        name: json["name"],
        password: json["password"],
        qrcode: json["qrcode"],
        surname: json["surname"],
        token: json["token"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "code": code,
        "confirmed": confirmed,
        "eco_coins": ecoCoins,
        "image": image,
        "name": name,
        "password": password,
        "qrcode": qrcode,
        "surname": surname,
        "token": token,
        "username": username,
    };
}