class OperatorModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  OperatorModel({this.status, this.message, this.data});

  OperatorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
  dynamic serviceID;
  dynamic title;
  dynamic image;
  dynamic minimiumAmount;
  dynamic maximumAmount;

  Data({this.serviceID, this.title, this.image,this.maximumAmount,this.minimiumAmount});

  Data.fromJson(Map<String, dynamic> json) {
    serviceID = json['serviceID'];
    title = json['title'];
    image = json['image'];
    minimiumAmount = json['minimium_amount'];
    maximumAmount = json['maximum_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['serviceID'] = serviceID;
    data['title'] = title;
    data['image'] = image;
    data['minimium_amount'] = minimiumAmount;
    data['maximum_amount'] = maximumAmount;
    return data;
  }
}
