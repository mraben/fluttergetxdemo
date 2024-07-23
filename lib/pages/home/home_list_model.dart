

class HomeListModel {
  int curpage =  1;
  int allnum =1;
  List<ListItemBean> newslist = [];


  HomeListModel();

  HomeListModel.fromJson(Map<String, dynamic> json) {
    curpage = json["curpage"];
    allnum = json["allnum"];
    if (json['newslist'] != null) {
      newslist = [];
      json['newslist'].forEach((v) {
        newslist?.add(ListItemBean.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map();
    data["curpage"] = curpage;
    data["allnum"] = allnum;
    if (newslist != null) {
      data['newslist'] = newslist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListItemBean {
  String? id;

  String? ctime;

  String? title;

  String? description;

  String? source;

  String? picUrl;

  String? url;

  ListItemBean.name({this.id, this.ctime, this.title, this.description,
      this.source, this.picUrl, this.url});

  ListItemBean.fromJson(Map<String,dynamic> json){
    id = json["id"];
    ctime = json["ctime"];
    title = json["title"];
    description = json["description"];
    source = json["source"];
    picUrl = json["picUrl"];
    url = json["url"];
  }

  Map<String,dynamic> toJson(){
    Map<String, dynamic> data = Map();
    data["id"] = id;
    data["ctime"] = ctime;
    data["title"] = title;
    data["description"] = description;
    data["source"] = source;
    data["picUrl"] = picUrl;
    data["url"] = url;
    return data;
  }
}
