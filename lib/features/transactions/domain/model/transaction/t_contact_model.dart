class TContact {
    TContact({
        this.name,
        this.phone,
    });

    String name;
    String phone;

    factory TContact.fromJson(Map<String, dynamic> json) => TContact(
        name: json["name"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
    };
}