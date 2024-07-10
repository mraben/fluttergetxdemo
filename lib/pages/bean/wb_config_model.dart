
class WbConfigModel {
  String? StringOne;
  String? StringTwo;
  bool? boolOne;

  WbConfigModel(
      {this.StringOne,
        this.StringTwo,
        this.boolOne});

  WbConfigModel.fromJson(Map<String, dynamic> json) {
    StringOne = json['String_one'];
    StringTwo = json['String_two'];
    boolOne = json['bool_one'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['String_one'] = this.StringOne;
    data['String_two'] = this.StringTwo;
    data['bool_one'] = this.boolOne;
    return data;
  }
}
