class ElectricityPlanModel {
  dynamic status;
  dynamic message;
  Data? data;

  ElectricityPlanModel({this.status, this.message, this.data});

  ElectricityPlanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  dynamic customerName;
  dynamic meterNumber;
  dynamic customerDistrict;
  dynamic address;

  Data(
      {this.customerName,
        this.meterNumber,
        this.customerDistrict,
        this.address});

  Data.fromJson(Map<String, dynamic> json) {
    customerName = json['Customer_Name'];
    meterNumber = json['Meter_Number'];
    customerDistrict = json['Customer_District'];
    address = json['Address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['Customer_Name'] = customerName;
    data['Meter_Number'] = meterNumber;
    data['Customer_District'] = customerDistrict;
    data['Address'] = address;
    return data;
  }
}
