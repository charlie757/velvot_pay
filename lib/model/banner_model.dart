class BannerModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  BannerModel({this.status, this.message, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic sId;
  dynamic title;
  dynamic image;
  dynamic imageUrl;
  dynamic imageThumbUrl;
  dynamic id;

  Data(
      {this.sId,
      this.title,
      this.image,
      this.imageUrl,
      this.imageThumbUrl,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    image = json['image'];
    imageUrl = json['image_url'];
    imageThumbUrl = json['image_thumb_url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['title'] = title;
    data['image'] = image;
    data['image_url'] = imageUrl;
    data['image_thumb_url'] = imageThumbUrl;
    data['id'] = id;
    return data;
  }
}
