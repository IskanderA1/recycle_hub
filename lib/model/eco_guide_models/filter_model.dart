class FilterModel {
  Id iId;
  String name;
  String varName;
  List<String> keyWords;
  List<String> badWords;

  FilterModel(
      {this.iId, this.name, this.varName, this.keyWords, this.badWords});

  FilterModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    name = json['name'];
    varName = json['var_name'];
    keyWords = json['key_words'].cast<String>();
    badWords = json['bad_words'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId.toJson();
    }
    data['name'] = this.name;
    data['var_name'] = this.varName;
    data['key_words'] = this.keyWords;
    data['bad_words'] = this.badWords;
    return data;
  }
}

class Id {
  String oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oid'] = this.oid;
    return data;
  }
}
