class ProfileModel {
  dynamic status;
  dynamic message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic sId;
  dynamic mobileNumber;
  dynamic apiToken;
  dynamic firstName;
  dynamic email;
  dynamic imageUrl;
  dynamic address;

  Data(
      {this.sId,
      this.mobileNumber,
      this.apiToken,
      this.firstName,
      this.email,
      this.imageUrl,
      this.address});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mobileNumber = json['mobile_number'];
    apiToken = json['api_token'];
    firstName = json['first_name'];
    email = json['email'];
    imageUrl = json['image_url'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['mobile_number'] = mobileNumber;
    data['api_token'] = apiToken;
    data['first_name'] = firstName;
    data['email'] = email;
    data['image_url'] = imageUrl;
    data['address'] = address;
    return data;
  }
}
