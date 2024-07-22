

class HomeMarqueeModel {
  String? content;

  HomeMarqueeModel({this.content});

  HomeMarqueeModel.fromJson(Map<String, dynamic> json) {

    content = json["content"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["content"] = this.content;
    return data;
  }
}
