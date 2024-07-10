class HomeBannerModel {
  String? image;
  String? url;

  HomeBannerModel(
      {
        this.image,
        this.url,
      });
  HomeBannerModel.fromJson(Map<String, dynamic> json) {
    image = json['image'].toString();
    url = json['url'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['url'] = this.url;
    return data;
  }
}