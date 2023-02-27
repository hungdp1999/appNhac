class RegionModel {
  RegionModel({this.name, this.code});

  RegionModel.fromJson(Map json) {
    name = json['name'] as String;
    code = json['code']?.toLowerCase() as String;
  }

  String? name;
  String? code;

  Map<String, String> toJson() {
    final data = <String, String>{};
    data['name'] = name ?? '';
    data['code'] = code ?? '';

    return data;
  }
}
