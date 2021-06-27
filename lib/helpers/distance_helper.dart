import 'dart:math';

double distanceInKm(Point p1, Point p2) {
    var lat1 = p1.x;
    var lon1 = p1.y;
    var lat2 = p2.x;
    var lon2 = p2.y;
    var p = 0.017453292519943295; // Math.PI / 180
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }