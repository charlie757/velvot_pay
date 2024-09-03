class DashboardModel {
  dynamic status;
  dynamic message;
  Data? data;

  DashboardModel({this.status, this.message, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
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
  dynamic walletAmount;
  List<Transaction>? transaction;

  Data({this.walletAmount, this.transaction});

  Data.fromJson(Map<String, dynamic> json) {
    walletAmount = json['walletAmount'];
    if (json['transaction'] != null) {
      transaction = <Transaction>[];
      json['transaction'].forEach((v) { transaction!.add( Transaction.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['walletAmount'] = walletAmount;
    if (transaction != null) {
      data['transaction'] = transaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  dynamic sId;
  dynamic title;
  dynamic type;
  dynamic number;
  // PaymentData? paymentData;
  dynamic amount;
  dynamic date;
  Operator? operator;
  dynamic transactionType;

  Transaction({this.sId, this.title, this.type, this.number,
    // this.paymentData,
    this.amount, this.date, this.operator, this.transactionType});

  Transaction.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    type = json['type'];
    number = json['number'];
    // paymentData = json['payment_data'] != null ?  PaymentData.fromJson(json['payment_data']) : null;
    amount = json['amount'];
    date = json['date'];
    operator = json['operator'] != null ?  Operator.fromJson(json['operator']) : null;
    transactionType = json['transactions_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['_id'] = sId;
    data['title'] = title;
    data['type'] = type;
    data['number'] = number;
    // if (paymentData != null) {
    //   data['payment_data'] = paymentData!.toJson();
    // }
    data['amount'] = amount;
    data['date'] = date;
    if (operator != null) {
      data['operator'] = operator!.toJson();
    }
    data['transactions_type'] = transactionType;
    return data;
  }
}

// class PaymentData {
//
//
//   PaymentData({});
//
// PaymentData.fromJson(Map<String, dynamic> json) {
// }

// Map<String, dynamic> toJson() {
// final Map<String, dynamic> data = new Map<String, dynamic>();
// return data;
// }
// }

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
final Map<String, dynamic> data =  Map<String, dynamic>();
data['serviceID'] = serviceID;
data['title'] = title;
data['image'] = image;
return data;
}
}
