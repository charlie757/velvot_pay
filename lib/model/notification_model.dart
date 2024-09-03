class NotificationModel {
  dynamic status;
  dynamic message;
  Data? data;

  NotificationModel({this.status, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Item>? item;
  dynamic notificationCount;

  Data({this.item, this.notificationCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add( Item.fromJson(v));
      });
    }
    notificationCount = json['notificationCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (item != null) {
      data['item'] = item!.map((v) => v.toJson()).toList();
    }
    data['notificationCount'] = notificationCount;
    return data;
  }
}

class Item {
  dynamic sId;
  List<Items>? items;

  Item({this.sId, this.items});

  Item.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add( Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['_id'] = sId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  dynamic sId;
  dynamic createdAt;
  dynamic title;
  dynamic description;
  dynamic image;

  Items({this.sId, this.createdAt, this.title, this.description, this.image});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['created_at'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['_id'] = sId;
    data['created_at'] = createdAt;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
