import 'dart:convert';

class CompanyProfileModel {
  final String companySlNo;
  final String companyName;
  final String repotHeading;
  final String description;
  final String companyLogoOrg;
  final String companyLogoThum;
  final String companyMobile;
  final String companyMobile2;
  final String companyEmail;
  final String facebook;
  final String twitter;
  final String instagram;
  final String youtube;
  final String pinterest;
  final String linkedin;
  final String companyGoogleMap;
  final String invoiceType;
  final String currencyName;
  final dynamic currencySymbol;
  final dynamic subCurrencyName;
  final String printType;
  final String companyBrunchId;
  final String walletAdjustment;
  final String referralCommission;
  final String customerVat;
  final String registerBonus;
  final String headerRightItem;
  final String headerRightItemLink;

  CompanyProfileModel({
    required this.companySlNo,
    required this.companyName,
    required this.repotHeading,
    required this.description,
    required this.companyLogoOrg,
    required this.companyLogoThum,
    required this.companyMobile,
    required this.companyMobile2,
    required this.companyEmail,
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.youtube,
    required this.pinterest,
    required this.linkedin,
    required this.companyGoogleMap,
    required this.invoiceType,
    required this.currencyName,
    required this.currencySymbol,
    required this.subCurrencyName,
    required this.printType,
    required this.companyBrunchId,
    required this.walletAdjustment,
    required this.referralCommission,
    required this.customerVat,
    required this.registerBonus,
    required this.headerRightItem,
    required this.headerRightItemLink,
  });

  factory CompanyProfileModel.fromJson(String str) => CompanyProfileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CompanyProfileModel.fromMap(Map<String, dynamic> json) => CompanyProfileModel(
    companySlNo: json["Company_SlNo"]??"",
    companyName: json["Company_Name"]??"",
    repotHeading: json["Repot_Heading"]??"",
    description: json["description"]??"",
    companyLogoOrg: json["Company_Logo_org"]??"",
    companyLogoThum: json["Company_Logo_thum"]??"",
    companyMobile: json["Company_mobile"]??"",
    companyMobile2: json["Company_mobile2"]??"",
    companyEmail: json["Company_email"]??"",
    facebook: json["facebook"]??"",
    twitter: json["twitter"]??"",
    instagram: json["Instagram"]??"",
    youtube: json["youtube"]??"",
    pinterest: json["pinterest"]??"",
    linkedin: json["linkedin"]??"",
    companyGoogleMap: json["Company_google_map"]??"",
    invoiceType: json["Invoice_Type"]??"",
    currencyName: json["Currency_Name"]??"",
    currencySymbol: json["Currency_Symbol"],
    subCurrencyName: json["SubCurrency_Name"],
    printType: json["print_type"]??"",
    companyBrunchId: json["company_BrunchId"]??"",
    walletAdjustment: json["wallet_adjustment"]??"",
    referralCommission: json["referral_commission"]??"",
    customerVat: json["customer_vat"]??"",
    registerBonus: json["register_bonus"]??"",
    headerRightItem: json["header_right_item"]??"",
    headerRightItemLink: json["header_right_item_link"]??"",
  );

  Map<String, dynamic> toMap() => {
    "Company_SlNo": companySlNo,
    "Company_Name": companyName,
    "Repot_Heading": repotHeading,
    "description": description,
    "Company_Logo_org": companyLogoOrg,
    "Company_Logo_thum": companyLogoThum,
    "Company_mobile": companyMobile,
    "Company_mobile2": companyMobile2,
    "Company_email": companyEmail,
    "facebook": facebook,
    "twitter": twitter,
    "Instagram": instagram,
    "youtube": youtube,
    "pinterest": pinterest,
    "linkedin": linkedin,
    "Company_google_map": companyGoogleMap,
    "Invoice_Type": invoiceType,
    "Currency_Name": currencyName,
    "Currency_Symbol": currencySymbol,
    "SubCurrency_Name": subCurrencyName,
    "print_type": printType,
    "company_BrunchId": companyBrunchId,
    "wallet_adjustment": walletAdjustment,
    "referral_commission": referralCommission,
    "customer_vat": customerVat,
    "register_bonus": registerBonus,
    "header_right_item": headerRightItem,
    "header_right_item_link": headerRightItemLink,
  };
}
