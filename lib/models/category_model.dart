class CategoryModel {
  CategoryModel({
    this.name,
    this.code,
    this.thumb,
  });

  CategoryModel.fromJson(Map json) {
    name = json['name'] as String;
    code = json['code'] as String;
    thumb = json['thumb'] as String;
  }

  String ?name;
  String ?code;
  String ?thumb;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['thumb'] = thumb;
    return data;
  }
}
