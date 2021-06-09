/*       
class FilterType {
    FilterType({
        this.id,
        this.badWords,
        this.keyWords,
        this.name,
        this.varName,
    });


    String id;
    List<String> badWords;
    List<String> keyWords;
    String name;
    String varName;

    factory FilterType.fromJson(Map<String, dynamic> json) => FilterType(
        id: json["_id"],
        badWords: List<String>.from(json["bad_words"].map((x) => x)),
        keyWords: List<String>.from(json["key_words"].map((x) => x)),
        name: json["name"],
        varName: json["var_name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "bad_words": List<dynamic>.from(badWords.map((x) => x)),
        "key_words": List<dynamic>.from(keyWords.map((x) => x)),
        "name": name,
        "var_name": varName,
    };
} */