class ProfileModel {
  dynamic status;
  dynamic message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  dynamic sId;
  dynamic mobileNumber;
  dynamic apiToken;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic imageUrl;
  dynamic address;
  dynamic isOtpVerify;
  dynamic isOtpEmail;
  dynamic isPinSetup;
  dynamic isCompleteProfile;
  dynamic isPasswordSetup;
  dynamic isBankAccount;
  Data(
      {this.sId,
        this.mobileNumber,
        this.apiToken,
        this.firstName,
        this.lastName,
        this.email,
        this.imageUrl,
        this.address,
        this.isOtpVerify,
        this.isOtpEmail,
        this.isPinSetup,
        this.isCompleteProfile,
        this.isPasswordSetup,this.isBankAccount});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mobileNumber = json['mobile_number'];
    apiToken = json['api_token'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    imageUrl = json['image_url'];
    address = json['address'];
    isOtpVerify = json['is_otp_verify'];
    isOtpEmail = json['is_otp_email'];
    isPinSetup = json['is_pin_setup'];
    isCompleteProfile = json['is_complete_profile'];
    isPasswordSetup = json['is_password_setup'];
    isBankAccount = json['is_bank_account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['_id'] = sId;
    data['mobile_number'] = mobileNumber;
    data['api_token'] = apiToken;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['image_url'] = imageUrl;
    data['address'] = address;
    data['is_otp_verify'] = isOtpVerify;
    data['is_otp_email'] = isOtpEmail;
    data['is_pin_setup'] = isPinSetup;
    data['is_complete_profile'] = isCompleteProfile;
    data['is_password_setup'] = isPasswordSetup;
    data['is_bank_account']  = isBankAccount;
    return data;
  }
}
