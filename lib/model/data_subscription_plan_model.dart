class DataSubscriptionPlanModel {
  dynamic status;
  dynamic message;
  Data? data;

  DataSubscriptionPlanModel({this.status, this.message, this.data});

  DataSubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
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
  dynamic serviceName;
  dynamic serviceID;
  dynamic convinienceFee;
  List<Varations>? varations;

  Data({this.serviceName, this.serviceID, this.convinienceFee, this.varations});

  Data.fromJson(Map<String, dynamic> json) {
    serviceName = json['ServiceName'];
    serviceID = json['serviceID'];
    convinienceFee = json['convinience_fee'];
    if (json['varations'] != null) {
      varations = <Varations>[];
      json['varations'].forEach((v) {
        varations!.add( Varations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['ServiceName'] = serviceName;
    data['serviceID'] = serviceID;
    data['convinience_fee'] = convinienceFee;
    if (varations != null) {
      data['varations'] = varations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Varations {
  dynamic variationCode;
  dynamic name;
  dynamic price;
  dynamic dataT;
  dynamic time;
  dynamic variationAmount;
  dynamic fixedPrice;

  Varations(
      {this.variationCode, this.name, this.variationAmount, this.fixedPrice,this.price,this.dataT,this.time });

  Varations.fromJson(Map<String, dynamic> json) {
    variationCode = json['variation_code'];
    name = json['name'];
    price = json['price'];
    dataT = json['data'];
    time = json['time'];
    variationAmount = json['variation_amount'];
    fixedPrice = json['fixedPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['variation_code'] = variationCode;
    data['name'] = name;
    data['price'] = price;
    data['data'] = dataT;
    data['time'] = time;
    data['variation_amount'] = variationAmount;
    data['fixedPrice'] = fixedPrice;
    return data;
  }
}
