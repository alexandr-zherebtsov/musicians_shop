class InstrumentTypeModel {
  String? id;
  String? type;

  InstrumentTypeModel({
    this.id,
    this.type,
  });

  InstrumentTypeModel.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}
