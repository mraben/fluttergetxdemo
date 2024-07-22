part of JWTools;

class JWBaseModel {
  int? code;
  String? msg;
  dynamic data;

  JWBaseModel({this.code, this.msg, this.data,});

  factory JWBaseModel.fromRawJson(String str) => JWBaseModel.fromJson(json
      .decode(str) as Map<String,dynamic>);
  factory JWBaseModel.fromJson(Map<String, dynamic> json) => JWBaseModel(
    code: json["code"],
      msg: json["msg"].toString(),
      data: json["data"] ?? ""
  );
  Map<String,dynamic> toJson() => {
    "code":code,
    "msg":msg,
    "data":data
  };
   bool get isOK => code == 200 || code == 0;

}
