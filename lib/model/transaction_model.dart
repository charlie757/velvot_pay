class TransactionModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  TransactionModel({this.status, this.message, this.data});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
  List<Items>? items;

  Data({this.sId, this.items});

  Data.fromJson(Map<String, dynamic> json) {
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
  dynamic title;
  dynamic number;
  dynamic transactionId;
  dynamic amount;
  dynamic date;
  dynamic type;
  Operator? operator;
  dynamic transactionType;
  Items(
      {this.sId,
        this.title,
        this.number,
        this.transactionId,
        this.amount,
        this.date,
        this.type,
        this.operator,this.transactionType});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    number = json['number'];
    transactionId = json['transactionId'];
    amount = json['amount'];
    date = json['date'];
    type = json['type'];
    operator = json['operator'] != null
        ?  Operator.fromJson(json['operator'])
        : null;
    transactionType = json['transactions_type']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['_id'] = sId;
    data['title'] = title;
    data['number'] = number;
    data['transactionId'] = transactionId;
    data['amount'] = amount;
    data['date'] = date;
    data['type'] = type;
    if (operator != null) {
      data['operator'] = operator!.toJson();
    }
    data['transactions_type'] = transactionType;
    return data;
  }
}

class Operator {
  dynamic serviceID;
  dynamic title;
  dynamic image;

  Operator({this.serviceID, this.title, this.image});

  Operator.fromJson(Map<String, dynamic> json) {
    serviceID = json['serviceID'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceID'] = serviceID;
    data['title'] = title;
    data['image'] = image;
    return data;
  }
}
