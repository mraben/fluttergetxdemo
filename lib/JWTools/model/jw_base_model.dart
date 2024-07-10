part of JWTools;

class JWBaseModel {
  int? code;
  String? message;
  String? request_id;
  dynamic data;

  JWBaseModel({this.code, this.message, this.data, this.request_id});

  factory JWBaseModel.fromRawJson(String str) => JWBaseModel.fromJson(json
      .decode(str) as Map<String,dynamic>);
  factory JWBaseModel.fromJson(Map<String, dynamic> json) => JWBaseModel(
    code: json["code"],
    message: json["message"].toString(),
    request_id: json["request_id"].toString(),
    data: json["data"] ?? ""
  );
  Map<String,dynamic> toJson() => {
    "code":code,
    "message":message,
    "request_id":request_id,
    "data":data
  };
   bool get isOK => code == 200 || code == 0;

}
