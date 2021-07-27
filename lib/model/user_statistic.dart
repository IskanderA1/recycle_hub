// To parse this JSON data, do
//
//     final userStatistic = userStatisticFromMap(jsonString);

import 'dart:convert';

class UserStatistic {
    UserStatistic({
        this.place,
        this.total,
        this.items,
    });

    int place;
    double total;
    List<UserStatisticItem> items;

    UserStatistic copyWith({
        int place,
        int total,
        List<UserStatisticItem> items,
    }) => 
        UserStatistic(
            place: place ?? this.place,
            total: total ?? this.total,
            items: items ?? this.items,
        );

    factory UserStatistic.fromJson(String str) => UserStatistic.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserStatistic.fromMap(Map<String, dynamic> json) => UserStatistic(
        place: json["place"] == null ? null : json["place"],
        total: json["total"] == null ? null : json["total"],
        items: json["items"] == null ? null : List<UserStatisticItem>.from(json["items"].map((x) => UserStatisticItem.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "place": place == null ? null : place,
        "total": total == null ? null : total,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

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
