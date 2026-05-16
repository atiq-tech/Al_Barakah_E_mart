import 'dart:convert';

class MyOrderModel {
  final String saleMasterSlNo;
  final String saleMasterSaleDate;
  final String saleMasterInvoiceNo;
  final String salseCustomerIdNo;
  final String bound;
  final String shippingCustomerName;
  final String shippingCustomerPhone;
  final String shippingCustomerEmail;
  final String shippingAddress;
  final String saleMasterDescription;
  final String areaId;
  final String deliveryOptionId;
  final String paymentType;
  final String isWalletAdjustment;
  final String saleMasterSubTotalAmount;
  final String saleMasterTotalCashbackAmount;
  final String saleMasterFreight;
  final String saleMasterTaxAmount;
  final String saleMasterTotalSaleAmount;
  final String walletAdjustmentAmount;
  final String walletSavings;
  final String payableAmount;
  final String previousWalletBalance;
  final String walletAdjustmentPercent;
  final String walletUptoAdjustmentPercent;
  final String vatPercent;
  final String saleMasterPaidAmount;
  final String saleMasterDueAmount;
  final String status;
  final dynamic addBy;
  final String addTime;
  final dynamic updateBy;
  final dynamic updateTime;
  final String saleMasterBranchid;
  final String saleStatusId;
  final dynamic onlinePaymentTrx;
  final dynamic onlinePaymentMethod;
  final dynamic onlinePaymentTime;
  final String paymentStatus;
  final dynamic referralId;
  final String referralCommissionPercent;
  final String referralCommissionAmount;
  final String orderFeedback;
  final String customerCode;
  final String districtName;
  final String saleStatus;

  MyOrderModel({
    required this.saleMasterSlNo,
    required this.saleMasterSaleDate,
    required this.saleMasterInvoiceNo,
    required this.salseCustomerIdNo,
    required this.bound,
    required this.shippingCustomerName,
    required this.shippingCustomerPhone,
    required this.shippingCustomerEmail,
    required this.shippingAddress,
    required this.saleMasterDescription,
    required this.areaId,
    required this.deliveryOptionId,
    required this.paymentType,
    required this.isWalletAdjustment,
    required this.saleMasterSubTotalAmount,
    required this.saleMasterTotalCashbackAmount,
    required this.saleMasterFreight,
    required this.saleMasterTaxAmount,
    required this.saleMasterTotalSaleAmount,
    required this.walletAdjustmentAmount,
    required this.walletSavings,
    required this.payableAmount,
    required this.previousWalletBalance,
    required this.walletAdjustmentPercent,
    required this.walletUptoAdjustmentPercent,
    required this.vatPercent,
    required this.saleMasterPaidAmount,
    required this.saleMasterDueAmount,
    required this.status,
    required this.addBy,
    required this.addTime,
    required this.updateBy,
    required this.updateTime,
    required this.saleMasterBranchid,
    required this.saleStatusId,
    required this.onlinePaymentTrx,
    required this.onlinePaymentMethod,
    required this.onlinePaymentTime,
    required this.paymentStatus,
    required this.referralId,
    required this.referralCommissionPercent,
    required this.referralCommissionAmount,
    required this.orderFeedback,
    required this.customerCode,
    required this.districtName,
    required this.saleStatus,
  });

  factory MyOrderModel.fromJson(String str) => MyOrderModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyOrderModel.fromMap(Map<String, dynamic> json) => MyOrderModel(
    saleMasterSlNo: json["SaleMaster_SlNo"]??"",
    saleMasterSaleDate: json["SaleMaster_SaleDate"]??"",
    saleMasterInvoiceNo: json["SaleMaster_InvoiceNo"]??"",
    salseCustomerIdNo: json["SalseCustomer_IDNo"]??"",
    bound: json["bound"]??"",
    shippingCustomerName: json["shipping_customer_name"]??"",
    shippingCustomerPhone: json["shipping_customer_phone"]??"",
    shippingCustomerEmail: json["shipping_customer_email"]??"",
    shippingAddress: json["shipping_address"]??"",
    saleMasterDescription: json["SaleMaster_Description"]??"",
    areaId: json["area_id"]??"",
    deliveryOptionId: json["delivery_option_id"]??"",
    paymentType: json["payment_type"]??"",
    isWalletAdjustment: json["is_wallet_adjustment"]??"",
    saleMasterSubTotalAmount: json["SaleMaster_SubTotalAmount"]??"",
    saleMasterTotalCashbackAmount: json["SaleMaster_TotalCashbackAmount"]??"",
    saleMasterFreight: json["SaleMaster_Freight"]??"",
    saleMasterTaxAmount: json["SaleMaster_TaxAmount"]??"",
    saleMasterTotalSaleAmount: json["SaleMaster_TotalSaleAmount"]??"",
    walletAdjustmentAmount: json["wallet_adjustment_amount"]??"",
    walletSavings: json["wallet_savings"]??"",
    payableAmount: json["payable_amount"]??"",
    previousWalletBalance: json["previous_wallet_balance"]??"",
    walletAdjustmentPercent: json["wallet_adjustment_percent"]??"",
    walletUptoAdjustmentPercent: json["wallet_upto_adjustment_percent"]??"",
    vatPercent: json["vat_percent"]??"",
    saleMasterPaidAmount: json["SaleMaster_PaidAmount"]??"",
    saleMasterDueAmount: json["SaleMaster_DueAmount"]??"",
    status: json["Status"]??"",
    addBy: json["AddBy"],
    addTime: json["AddTime"]??"",
    updateBy: json["UpdateBy"],
    updateTime: json["UpdateTime"],
    saleMasterBranchid: json["SaleMaster_branchid"]??"",
    saleStatusId: json["sale_status_id"]??"",
    onlinePaymentTrx: json["online_payment_trx"],
    onlinePaymentMethod: json["online_payment_method"],
    onlinePaymentTime: json["online_payment_time"],
    paymentStatus: json["payment_status"]??"",
    referralId: json["referral_id"],
    referralCommissionPercent: json["referral_commission_percent"]??"",
    referralCommissionAmount: json["referral_commission_amount"]??"",
    orderFeedback: json["order_feedback"]??"",
    customerCode: json["Customer_Code"]??"",
    districtName: json["District_Name"]??"",
    saleStatus: json["sale_status"]??"",
  );

  Map<String, dynamic> toMap() => {
    "SaleMaster_SlNo": saleMasterSlNo,
    "SaleMaster_SaleDate": saleMasterSaleDate,
    "SaleMaster_InvoiceNo": saleMasterInvoiceNo,
    "SalseCustomer_IDNo": salseCustomerIdNo,
    "bound": bound,
    "shipping_customer_name": shippingCustomerName,
    "shipping_customer_phone": shippingCustomerPhone,
    "shipping_customer_email": shippingCustomerEmail,
    "shipping_address": shippingAddress,
    "SaleMaster_Description": saleMasterDescription,
    "area_id": areaId,
    "delivery_option_id": deliveryOptionId,
    "payment_type": paymentType,
    "is_wallet_adjustment": isWalletAdjustment,
    "SaleMaster_SubTotalAmount": saleMasterSubTotalAmount,
    "SaleMaster_TotalCashbackAmount": saleMasterTotalCashbackAmount,
    "SaleMaster_Freight": saleMasterFreight,
    "SaleMaster_TaxAmount": saleMasterTaxAmount,
    "SaleMaster_TotalSaleAmount": saleMasterTotalSaleAmount,
    "wallet_adjustment_amount": walletAdjustmentAmount,
    "wallet_savings": walletSavings,
    "payable_amount": payableAmount,
    "previous_wallet_balance": previousWalletBalance,
    "wallet_adjustment_percent": walletAdjustmentPercent,
    "wallet_upto_adjustment_percent": walletUptoAdjustmentPercent,
    "vat_percent": vatPercent,
    "SaleMaster_PaidAmount": saleMasterPaidAmount,
    "SaleMaster_DueAmount": saleMasterDueAmount,
    "Status": status,
    "AddBy": addBy,
    "AddTime": addTime,
    "UpdateBy": updateBy,
    "UpdateTime": updateTime,
    "SaleMaster_branchid": saleMasterBranchid,
    "sale_status_id": saleStatusId,
    "online_payment_trx": onlinePaymentTrx,
    "online_payment_method": onlinePaymentMethod,
    "online_payment_time": onlinePaymentTime,
    "payment_status": paymentStatus,
    "referral_id": referralId,
    "referral_commission_percent": referralCommissionPercent,
    "referral_commission_amount": referralCommissionAmount,
    "order_feedback": orderFeedback,
    "Customer_Code": customerCode,
    "District_Name": districtName,
    "sale_status": saleStatus,
  };
}
