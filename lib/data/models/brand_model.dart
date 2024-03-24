class BrandModel {
  String? id;
  String? name;

  BrandModel({
    this.id,
    this.name,
  });

  BrandModel.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
