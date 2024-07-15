class TransactionDetailsModel {
  dynamic status;
  dynamic message;
  Data? data;

  TransactionDetailsModel({this.status, this.message, this.data});

  TransactionDetailsModel.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic amount;
  dynamic productName;
  dynamic number;
  dynamic transactionId;
  Operator? operator;
  dynamic type;
  dynamic policyCertificate;
  dynamic requestId;
  dynamic date;
  PaymentData? paymentData;

  Data({this.id, this.amount, this.productName, this.number, this.transactionId, this.operator, this.type, this.policyCertificate, this.requestId, this.date, this.paymentData});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    productName = json['product_name'];
    number = json['number'];
    transactionId = json['transactionId'];
    operator = json['operator'] != null ?  Operator.fromJson(json['operator']) : null;
    type = json['type'];
    policyCertificate = json['policy_certificate'];
    requestId = json['requestId'];
    date = json['date'];
    paymentData = json['payment_data'] != null ?  PaymentData.fromJson(json['payment_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['amount'] = amount;
    data['product_name'] = productName;
    data['number'] =number;
    data['transactionId'] = transactionId;
    if (operator != null) {
      data['operator'] = operator!.toJson();
    }
    data['type'] = type;
    data['policy_certificate'] = policyCertificate;
    data['requestId'] = requestId;
    data['date'] = this.date;
    if (paymentData != null) {
      data['payment_data'] = paymentData!.toJson();
    }
    return data;
  }
}

class Operator {
  String? serviceID;
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
class PaymentData {
  Card? card;
  dynamic verify;
  dynamic reference;
  dynamic method;

  PaymentData({this.card, this.verify, this.reference, this.method});

  PaymentData.fromJson(Map<String, dynamic> json) {
    card = json['card'] != null ?  Card.fromJson(json['card']) : null;
    verify = json['verify'];
    reference = json['reference'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (card != null) {
      data['card'] = card!.toJson();
    }
    data['verify'] = verify;
    data['reference'] = reference;
    data['method'] = method;
    return data;
  }
}

class Card {
  dynamic cvc;
  dynamic expiryMonth;
  dynamic expiryYear;
  dynamic name;
  dynamic type;
  dynamic last4Digit;

  Card(
      {this.cvc,
        this.expiryMonth,
        this.expiryYear,
        this.name,
        this.type,
        this.last4Digit});

  Card.fromJson(Map<String, dynamic> json) {
    cvc = json['cvc'];
    expiryMonth = json['expiryMonth'];
    expiryYear = json['expiryYear'];
    name = json['name'];
    type = json['type'];
    last4Digit = json['last4Digit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['cvc'] = cvc;
    data['expiryMonth'] = expiryMonth;
    data['expiryYear'] = expiryYear;
    data['name'] = name;
    data['type'] = type;
    data['last4Digit'] = last4Digit;
    return data;
  }
}