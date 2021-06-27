import 'dart:convert';

class TestItem {
    TestItem({
        this.id,
        this.testName,
        this.description,
        this.coinsToUnlock,
        this.pointsToSuccess,
    });

    String id;
    String testName;
    String description;
    int coinsToUnlock;
    int pointsToSuccess;

    TestItem copyWith({
        String id,
        String testName,
        String description,
        int coinsToUnlock,
        int pointsToSuccess,
    }) => 
        TestItem(
            id: id ?? this.id,
            testName: testName ?? this.testName,
            description: description ?? this.description,
            coinsToUnlock: coinsToUnlock ?? this.coinsToUnlock,
            pointsToSuccess: pointsToSuccess ?? this.pointsToSuccess,
        );

    factory TestItem.fromJson(String str) => TestItem.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TestItem.fromMap(Map<String, dynamic> json) => TestItem(
        id: json["id"],
        testName: json["test_name"],
        description: json["description"],
        coinsToUnlock: json["coins_to_unlock"],
        pointsToSuccess: json["points_to_success"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "test_name": testName,
        "description": description,
        "coins_to_unlock": coinsToUnlock,
        "points_to_success": pointsToSuccess,
    };
}
