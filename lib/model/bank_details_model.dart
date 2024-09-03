class BankAccountModel {
  dynamic status;
  dynamic message;
  Data? data;

  BankAccountModel({this.status, this.message, this.data});

  BankAccountModel.fromJson(Map<String, dynamic> json) {
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
  dynamic bankName;
  dynamic accountNumber;
  dynamic accountHolderName;

  Data({this.bankName, this.accountNumber, this.accountHolderName});

  Data.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    accountHolderName = json['account_holder_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['account_holder_name'] = accountHolderName;
    return data;
  }
}
