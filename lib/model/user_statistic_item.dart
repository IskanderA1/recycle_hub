import 'dart:convert';

class UserStatisticItem {
    UserStatisticItem({
        this.filter,
        this.name,
        this.total,
    });

    String filter;
    String name;
    double total;

    UserStatisticItem copyWith({
        String filter,
        String name,
        double total,
    }) => 
        UserStatisticItem(
            filter: filter ?? this.filter,
            name: name ?? this.name,
            total: total ?? this.total,
        );

    factory UserStatisticItem.fromJson(String str) => UserStatisticItem.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserStatisticItem.fromMap(Map<String, dynamic> json) => UserStatisticItem(
        filter: json["filter"] == null ? null : json["filter"],
        name: json["name"] == null ? null : json["name"],
        total: json["total"] == null ? null : json["total"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "filter": filter == null ? null : filter,
        "name": name == null ? null : name,
        "total": total == null ? null : total,
    };
}