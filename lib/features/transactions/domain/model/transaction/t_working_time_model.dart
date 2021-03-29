class WorkTime {
    WorkTime({
        this.empty,
        this.workTime,
        this.purple,
        this.fluffy,
        this.tentacled,
        this.sticky,
        this.indigo,
    });

    Map<String, String> empty;
    Map<String, String> workTime;
    Map<String, String> purple;
    Map<String, String> fluffy;
    Map<String, String> tentacled;
    Map<String, String> sticky;
    Map<String, String> indigo;

    factory WorkTime.fromJson(Map<String, dynamic> json) => WorkTime(
        empty: Map.from(json["ВС"]).map((k, v) => MapEntry<String, String>(k, v)),
        workTime: Map.from(json["ВТ"]).map((k, v) => MapEntry<String, String>(k, v)),
        purple: Map.from(json["ПН"]).map((k, v) => MapEntry<String, String>(k, v)),
        fluffy: Map.from(json["ПТ"]).map((k, v) => MapEntry<String, String>(k, v)),
        tentacled: Map.from(json["СБ"]).map((k, v) => MapEntry<String, String>(k, v)),
        sticky: Map.from(json["СР"]).map((k, v) => MapEntry<String, String>(k, v)),
        indigo: Map.from(json["ЧТ"]).map((k, v) => MapEntry<String, String>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "ВС": Map.from(empty).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "ВТ": Map.from(workTime).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "ПН": Map.from(purple).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "ПТ": Map.from(fluffy).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "СБ": Map.from(tentacled).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "СР": Map.from(sticky).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "ЧТ": Map.from(indigo).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
