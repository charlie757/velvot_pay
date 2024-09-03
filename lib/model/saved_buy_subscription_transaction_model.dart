class SavedTransactionModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  SavedTransactionModel({this.status, this.message, this.data});

  SavedTransactionModel.fromJson(Map<String, dynamic> json) {
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
  dynamic type;
  dynamic transactionsType;
  dynamic transactionsMethod;
  dynamic certUrl;
  dynamic requestId;
  dynamic sId;
  Request? request;
  TransactionsData? transactionsData;
  dynamic userId;
  dynamic amount;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic id;

  Data(
      {this.type,
        this.transactionsType,
        this.transactionsMethod,
        this.certUrl,
        this.requestId,
        this.sId,
        this.request,
        this.transactionsData,
        this.userId,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    transactionsType = json['transactions_type'];
    transactionsMethod = json['transactions_method'];
    certUrl = json['certUrl'];
    requestId = json['requestId'];
    sId = json['_id'];
    request =
    json['request'] != null ?  Request.fromJson(json['request']) : null;
    transactionsData = json['transactions_data'] != null
        ?  TransactionsData.fromJson(json['transactions_data'])
        : null;
    userId = json['user_id'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['type'] = type;
    data['transactions_type'] = transactionsType;
    data['transactions_method'] = transactionsMethod;
    data['certUrl'] = certUrl;
    data['requestId'] = requestId;
    data['_id'] = sId;
    if (request != null) {
      data['request'] = request!.toJson();
    }
    if (transactionsData != null) {
      data['transactions_data'] = transactionsData!.toJson();
    }
    data['user_id'] = userId;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['id'] = id;
    return data;
  }
}

class Request {
  Operator? operator;
  dynamic serviceID;
  dynamic phone;
  dynamic planName;

  Request({this.operator, this.serviceID, this.phone, this.planName});

  Request.fromJson(Map<String, dynamic> json) {
    operator = json['operator'] != null
        ?  Operator.fromJson(json['operator'])
        : null;
    serviceID = json['serviceID'];
    phone = json['phone'];
    planName = json['plan_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (operator != null) {
      data['operator'] = operator!.toJson();
    }
    data['serviceID'] = serviceID;
    data['phone'] = phone;
    data['plan_name'] = planName;
    return data;
  }
}

class Operator {
  dynamic serviceID;
  dynamic title;
  dynamic image;
  dynamic type;

  Operator({this.serviceID, this.title, this.image});

  Operator.fromJson(Map<String, dynamic> json) {
    serviceID = json['serviceID'];
    title = json['title'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceID'] = serviceID;
    data['title'] = title;
    data['image'] = image;
    data['type'] = type;
    return data;
  }
}

class TransactionsData {
  dynamic status;
  dynamic productName;
  dynamic uniqueElement;
  dynamic unitPrice;
  dynamic quantity;
  dynamic serviceVerification;
  dynamic channel;
  dynamic commission;
  dynamic totalAmount;
  dynamic discount;
  dynamic type;
  dynamic email;
  dynamic phone;
  dynamic name;
  dynamic convinienceFee;
  dynamic amount;
  dynamic platform;
  dynamic method;
  dynamic transactionId;

  TransactionsData(
      {this.status,
        this.productName,
        this.uniqueElement,
        this.unitPrice,
        this.quantity,
        this.serviceVerification,
        this.channel,
        this.commission,
        this.totalAmount,
        this.discount,
        this.type,
        this.email,
        this.phone,
        this.name,
        this.convinienceFee,
        this.amount,
        this.platform,
        this.method,
        this.transactionId});

  TransactionsData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    productName = json['product_name'];
    uniqueElement = json['unique_element'];
    unitPrice = json['unit_price'];
    quantity = json['quantity'];
    serviceVerification = json['service_verification'];
    channel = json['channel'];
    commission = json['commission'];
    totalAmount = json['total_amount'];
    discount = json['discount'];
    type = json['type'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    convinienceFee = json['convinience_fee'];
    amount = json['amount'];
    platform = json['platform'];
    method = json['method'];
    transactionId = json['transactionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['product_name'] = productName;
    data['unique_element'] = uniqueElement;
    data['unit_price'] = unitPrice;
    data['quantity'] = quantity;
    data['service_verification'] = serviceVerification;
    data['channel'] = channel;
    data['commission'] = commission;
    data['total_amount'] = totalAmount;
    data['discount'] = discount;
    data['type'] = type;
    data['email'] = email;
    data['phone'] = phone;
    data['name'] = name;
    data['convinience_fee'] = convinienceFee;
    data['amount'] = amount;
    data['platform'] = platform;
    data['method'] = method;
    data['transactionId'] = transactionId;
    return data;
  }
}
