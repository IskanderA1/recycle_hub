class TCoords {
    TCoords({
        this.lat,
        this.lng,
    });

    double lat;
    double lng;

    factory TCoords.fromJson(Map<String, dynamic> json) => TCoords(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}