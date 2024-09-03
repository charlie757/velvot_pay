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
  dynamic paymentMethod;
  dynamic transactionsType;
  dynamic planName;
  dynamic date;

  Data(
      {this.id,
        this.amount,
        this.productName,
        this.number,
        this.transactionId,
        this.operator,
        this.type,
        this.policyCertificate,
        this.requestId,
        this.paymentMethod,
        this.transactionsType,
        this.planName,
        this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    productName = json['product_name'];
    number = json['number'];
    transactionId = json['transactionId'];
    operator = json['operator'] != null
        ?  Operator.fromJson(json['operator'])
        : null;
    type = json['type'];
    policyCertificate = json['policy_certificate'];
    requestId = json['requestId'];
    paymentMethod = json['payment_method'];
    transactionsType = json['transactions_type'];
    planName = json['plan_name'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['amount'] = amount;
    data['product_name'] = productName;
    data['number'] = number;
    data['transactionId'] = transactionId;
    if (operator != null) {
      data['operator'] = operator!.toJson();
    }
    data['type'] = type;
    data['policy_certificate'] = policyCertificate;
    data['requestId'] = requestId;
    data['payment_method'] = paymentMethod;
    data['transactions_type'] = transactionsType;
    data['plan_name'] = planName;
    data['date'] = date;
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
