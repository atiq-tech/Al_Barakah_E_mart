import 'dart:convert';

class UserProfileResponseModel {
  final String totalOrder;
  final String totalDelivary;
  final String totalCancel;
  final UserProfileModel userProfileModel;
  final String walletBalance;

  UserProfileResponseModel({
    required this.totalOrder,
    required this.totalDelivary,
    required this.totalCancel,
    required this.userProfileModel,
    required this.walletBalance,
  });

  factory UserProfileResponseModel.fromJson(String str) => UserProfileResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserProfileResponseModel.fromMap(Map<String, dynamic> json) => UserProfileResponseModel(
    totalOrder: json["total_order"] is int
        || json["total_order"] is double ? json["total_order"].toString()
        : json["total_order"] ?? "",
    totalDelivary: json["total_delivary"] is int
        || json["total_delivary"] is double ? json["total_delivary"].toString()
        : json["total_delivary"] ?? "",
    totalCancel: json["total_cancel"] is int
        || json["total_cancel"] is double ? json["total_cancel"].toString()
        : json["total_cancel"] ?? "",
    userProfileModel: UserProfileModel.fromMap(json["customer"]),
    walletBalance: json["wallet_balance"]  is int
        || json["wallet_balance"] is double ? json["wallet_balance"].toString()
        : json["wallet_balance"] ?? "",
  );

  Map<String, dynamic> toMap() => {
    "total_order": totalOrder,
    "total_delivary": totalDelivary,
    "total_cancel": totalCancel,
    "customer": userProfileModel.toMap(),
    "wallet_balance": walletBalance,
  };
}

class UserProfileModel {
  final String customerSlNo;
  final String customerCode;
  final String customerName;
  final String customerMobile;
  final String customerEmail;
  final String customerAddress;
  final dynamic countryId;
  final dynamic imageName;
  final String walletBalance;
  final String walletHangBalance;
  final String status;
  final dynamic addBy;
  final String addTime;
  final dynamic updateBy;
  final dynamic updateTime;
  final String customerBrunchid;
  final String bound;
  final String password;
  final String isAgreementPrivacyPolicy;
  final String isPhoneVerified;
  final String isEmailVerified;
  final dynamic referralId;
  final String registerBonus;
  final dynamic customerDob;
  final dynamic customerGender;
  final String oauthProvider;
  final String oauthUid;
  final String link;

  UserProfileModel({
    required this.customerSlNo,
    required this.customerCode,
    required this.customerName,
    required this.customerMobile,
    required this.customerEmail,
    required this.customerAddress,
    required this.countryId,
    required this.imageName,
    required this.walletBalance,
    required this.walletHangBalance,
    required this.status,
    required this.addBy,
    required this.addTime,
    required this.updateBy,
    required this.updateTime,
    required this.customerBrunchid,
    required this.bound,
    required this.password,
    required this.isAgreementPrivacyPolicy,
    required this.isPhoneVerified,
    required this.isEmailVerified,
    required this.referralId,
    required this.registerBonus,
    required this.customerDob,
    required this.customerGender,
    required this.oauthProvider,
    required this.oauthUid,
    required this.link,
  });

  factory UserProfileModel.fromJson(String str) => UserProfileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromMap(Map<String, dynamic> json) => UserProfileModel(
    customerSlNo: json["Customer_SlNo"]??"",
    customerCode: json["Customer_Code"]??"",
    customerName: json["Customer_Name"]??"",
    customerMobile: json["Customer_Mobile"]??"",
    customerEmail: json["Customer_Email"]??"",
    customerAddress: json["Customer_Address"]??"",
    countryId: json["country_id"],
    imageName: json["image_name"],
    walletBalance: json["wallet_balance"]??"",
    walletHangBalance: json["wallet_hang_balance"]??"",
    status: json["status"]??"",
    addBy: json["AddBy"],
    addTime: json["AddTime"]??"",
    updateBy: json["UpdateBy"],
    updateTime: json["UpdateTime"],
    customerBrunchid: json["Customer_brunchid"]??"",
    bound: json["bound"]??"",
    password: json["password"]??"",
    isAgreementPrivacyPolicy: json["is_agreement_privacy_policy"]??"",
    isPhoneVerified: json["is_phone_verified"]??"",
    isEmailVerified: json["is_email_verified"]??"",
    referralId: json["referral_id"],
    registerBonus: json["register_bonus"]??"",
    customerDob: json["Customer_DOB"],
    customerGender: json["Customer_gender"],
    oauthProvider: json["oauth_provider"]??"",
    oauthUid: json["oauth_uid"]??"",
    link: json["link"]??"",
  );

  Map<String, dynamic> toMap() => {
    "Customer_SlNo": customerSlNo,
    "Customer_Code": customerCode,
    "Customer_Name": customerName,
    "Customer_Mobile": customerMobile,
    "Customer_Email": customerEmail,
    "Customer_Address": customerAddress,
    "country_id": countryId,
    "image_name": imageName,
    "wallet_balance": walletBalance,
    "wallet_hang_balance": walletHangBalance,
    "status": status,
    "AddBy": addBy,
    "AddTime": addTime,
    "UpdateBy": updateBy,
    "UpdateTime": updateTime,
    "Customer_brunchid": customerBrunchid,
    "bound": bound,
    "password": password,
    "is_agreement_privacy_policy": isAgreementPrivacyPolicy,
    "is_phone_verified": isPhoneVerified,
    "is_email_verified": isEmailVerified,
    "referral_id": referralId,
    "register_bonus": registerBonus,
    "Customer_DOB": customerDob,
    "Customer_gender": customerGender,
    "oauth_provider": oauthProvider,
    "oauth_uid": oauthUid,
    "link": link,
  };
}
