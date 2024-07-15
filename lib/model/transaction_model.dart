class TransactionModel {
  int? status;
  String? message;
  Data? data;

  TransactionModel({this.status, this.message, this.data});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<TransData>? data;
  Pagination? pagination;

  Data({this.data, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TransData>[];
      json['data'].forEach((v) {
        data!.add( TransData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ?  Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class TransData {
  dynamic sId;
  dynamic title;
  dynamic number;
  dynamic transactionId;
  dynamic amount;
  dynamic date;
  dynamic type;
  Operator? operator;

  TransData(
      {this.sId,
        this.title,
        this.number,
        this.transactionId,
        this.amount,
        this.date,
        this.type,
        this.operator});

  TransData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['serviceID'] = serviceID;
    data['title'] = title;
    data['image'] = image;
    return data;
  }
}

class Pagination {
  dynamic total;
  dynamic count;
  dynamic perPage;
  dynamic currentPage;
  dynamic totalPages;
  dynamic nextPage;
  dynamic from;
  dynamic to;

  Pagination(
      {this.total,
        this.count,
        this.perPage,
        this.currentPage,
        this.totalPages,
        this.nextPage,
        this.from,
        this.to});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    nextPage = json['nextPage'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['total'] = total;
    data['count'] = count;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    data['nextPage'] = nextPage;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
