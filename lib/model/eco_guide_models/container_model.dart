class ContainerModel {
  String name;
  List<Allowed> allowed;
  List<Forbidden> forbidden;

  ContainerModel({this.name, this.allowed, this.forbidden});

  ContainerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['allowed'] != null) {
      allowed = new List<Allowed>.empty(growable: true);
      json['allowed'].forEach((v) {
        allowed.add(new Allowed.fromJson(v));
      });
    }
    if (json['forbidden'] != null) {
      forbidden = new List<Forbidden>.empty(growable: true);
      json['forbidden'].forEach((v) {
        forbidden.add(new Forbidden.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.allowed != null) {
      data['allowed'] = this.allowed.map((v) => v.toJson()).toList();
    }
    if (this.forbidden != null) {
      data['forbidden'] = this.forbidden.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Allowed {
  String name;
  List<Subjects> subjects;

  Allowed({this.name, this.subjects});

  Allowed.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['subjects'] != null) {
      subjects = new List<Subjects>.empty(growable: true);
      json['subjects'].forEach((v) {
        subjects.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.subjects != null) {
      data['subjects'] = this.subjects.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  String name;
  String photo;

  Subjects({this.name, this.photo});

  Subjects.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['photo'] = this.photo;
    return data;
  }
}

class Forbidden {
  String name;
  String photo;

  Forbidden({this.name, this.photo});

  Forbidden.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['photo'] = this.photo;
    return data;
  }
}
