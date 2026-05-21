import 'dart:convert';

class CustomerOrdersModel {
    final dynamic saleMasterSlNo;
    final dynamic saleMasterInvoiceNo;
    final dynamic salseCustomerIdNo;
    final dynamic exchangeReference;
    final dynamic customerType;
    final dynamic customerName;
    final dynamic customerMobile;
    final dynamic customerEmail;
    final dynamic customerAddress;
    final dynamic billingAddress;
    final dynamic deliveryDate;
    final dynamic deliverymanId;
    final dynamic deliveryOtp;
    final dynamic collectPayment;
    final dynamic thanaId;
    final dynamic areaId;
    final dynamic timeId;
    final dynamic employeeId;
    final dynamic bankAccountId;
    final dynamic saleMasterSaleDate;
    final dynamic saleMasterDescription;
    final dynamic saleMasterSaleType;
    final dynamic isOrder;
    final dynamic paymentType;
    final dynamic saleMasterTotalSaleAmount;
    final dynamic saleMasterTotalDiscountAmount;
    final dynamic discountPoint;
    final dynamic saleMasterTaxAmount;
    final dynamic saleMasterFreight;
    final dynamic saleMasterSubTotalAmount;
    final dynamic shippingCharge;
    final dynamic cashPaid;
    final dynamic bankPaid;
    final dynamic bankId;
    final dynamic transactionId;
    final dynamic saleMasterPaidAmount;
    final dynamic saleMasterDueAmount;
    final dynamic saleMasterPreviousDue;
    final dynamic returnAmount;
    final dynamic exchangeAmount;
    final dynamic promotionalDiscount;
    final dynamic specialDiscount;
    final dynamic salePoint;
    final dynamic usePoint;
    final dynamic status;
    final dynamic addBy;
    final dynamic createdAt;
    final dynamic updateBy;
    final dynamic updatedAt;
    final dynamic deletedBy;
    final dynamic deletedTime;
    final dynamic lastUpdateIp;
    final dynamic warehouseId;
    final dynamic branchId;
    final List<OrderDetail>? orderDetails;

    CustomerOrdersModel({
        required this.saleMasterSlNo,
        required this.saleMasterInvoiceNo,
        required this.salseCustomerIdNo,
        required this.exchangeReference,
        required this.customerType,
        required this.customerName,
        required this.customerMobile,
        required this.customerEmail,
        required this.customerAddress,
        required this.billingAddress,
        required this.deliveryDate,
        required this.deliverymanId,
        required this.deliveryOtp,
        required this.collectPayment,
        required this.thanaId,
        required this.areaId,
        required this.timeId,
        required this.employeeId,
        required this.bankAccountId,
        required this.saleMasterSaleDate,
        required this.saleMasterDescription,
        required this.saleMasterSaleType,
        required this.isOrder,
        required this.paymentType,
        required this.saleMasterTotalSaleAmount,
        required this.saleMasterTotalDiscountAmount,
        required this.discountPoint,
        required this.saleMasterTaxAmount,
        required this.saleMasterFreight,
        required this.saleMasterSubTotalAmount,
        required this.shippingCharge,
        required this.cashPaid,
        required this.bankPaid,
        required this.bankId,
        required this.transactionId,
        required this.saleMasterPaidAmount,
        required this.saleMasterDueAmount,
        required this.saleMasterPreviousDue,
        required this.returnAmount,
        required this.exchangeAmount,
        required this.promotionalDiscount,
        required this.specialDiscount,
        required this.salePoint,
        required this.usePoint,
        required this.status,
        required this.addBy,
        required this.createdAt,
        required this.updateBy,
        required this.updatedAt,
        required this.deletedBy,
        required this.deletedTime,
        required this.lastUpdateIp,
        required this.warehouseId,
        required this.branchId,
        required this.orderDetails,
    });

    factory CustomerOrdersModel.fromJson(String str) => CustomerOrdersModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CustomerOrdersModel.fromMap(Map<String, dynamic> json) => CustomerOrdersModel(
        saleMasterSlNo: json["SaleMaster_SlNo"],
        saleMasterInvoiceNo: json["SaleMaster_InvoiceNo"],
        salseCustomerIdNo: json["SalseCustomer_IDNo"],
        exchangeReference: json["exchange_reference"],
        customerType: json["customerType"],
        customerName: json["customerName"],
        customerMobile: json["customerMobile"],
        customerEmail: json["customerEmail"],
        customerAddress: json["customerAddress"],
        billingAddress: json["billingAddress"],
        deliveryDate: json["delivery_date"],
        deliverymanId: json["deliveryman_id"],
        deliveryOtp: json["delivery_otp"],
        collectPayment: json["collect_payment"],
        thanaId: json["thana_id"],
        areaId: json["area_id"],
        timeId: json["time_id"],
        employeeId: json["employee_id"],
        bankAccountId: json["bank_account_id"],
        saleMasterSaleDate: json["SaleMaster_SaleDate"],
        saleMasterDescription: json["SaleMaster_Description"],
        saleMasterSaleType: json["SaleMaster_SaleType"],
        isOrder: json["is_order"],
        paymentType: json["payment_type"],
        saleMasterTotalSaleAmount: json["SaleMaster_TotalSaleAmount"],
        saleMasterTotalDiscountAmount: json["SaleMaster_TotalDiscountAmount"],
        discountPoint: json["discount_point"],
        saleMasterTaxAmount: json["SaleMaster_TaxAmount"],
        saleMasterFreight: json["SaleMaster_Freight"],
        saleMasterSubTotalAmount: json["SaleMaster_SubTotalAmount"],
        shippingCharge: json["shipping_charge"],
        cashPaid: json["cashPaid"],
        bankPaid: json["bankPaid"],
        bankId: json["bank_id"],
        transactionId: json["transaction_id"],
        saleMasterPaidAmount: json["SaleMaster_PaidAmount"],
        saleMasterDueAmount: json["SaleMaster_DueAmount"],
        saleMasterPreviousDue: json["SaleMaster_Previous_Due"],
        returnAmount: json["returnAmount"],
        exchangeAmount: json["exchange_amount"],
        promotionalDiscount: json["promotional_discount"],
        specialDiscount: json["special_discount"],
        salePoint: json["sale_point"],
        usePoint: json["use_point"],
        status: json["status"],
        addBy: json["AddBy"],
        createdAt: json["created_at"],
        updateBy: json["UpdateBy"],
        updatedAt: json["updated_at"],
        deletedBy: json["DeletedBy"],
        deletedTime: json["DeletedTime"],
        lastUpdateIp: json["last_update_ip"],
        warehouseId: json["warehouse_id"],
        branchId: json["branch_id"],
        orderDetails: json["order_details"] == null || json["order_details"] == [] ? [] : List<OrderDetail>.from(json["order_details"].map((x) => OrderDetail.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "SaleMaster_SlNo": saleMasterSlNo,
        "SaleMaster_InvoiceNo": saleMasterInvoiceNo,
        "SalseCustomer_IDNo": salseCustomerIdNo,
        "exchange_reference": exchangeReference,
        "customerType": customerType,
        "customerName": customerName,
        "customerMobile": customerMobile,
        "customerEmail": customerEmail,
        "customerAddress": customerAddress,
        "billingAddress": billingAddress,
        "delivery_date": deliveryDate,
        "deliveryman_id": deliverymanId,
        "delivery_otp": deliveryOtp,
        "collect_payment": collectPayment,
        "thana_id": thanaId,
        "area_id": areaId,
        "time_id": timeId,
        "employee_id": employeeId,
        "bank_account_id": bankAccountId,
        "SaleMaster_SaleDate": saleMasterSaleDate,
        "SaleMaster_Description": saleMasterDescription,
        "SaleMaster_SaleType": saleMasterSaleType,
        "is_order": isOrder,
        "payment_type": paymentType,
        "SaleMaster_TotalSaleAmount": saleMasterTotalSaleAmount,
        "SaleMaster_TotalDiscountAmount": saleMasterTotalDiscountAmount,
        "discount_point": discountPoint,
        "SaleMaster_TaxAmount": saleMasterTaxAmount,
        "SaleMaster_Freight": saleMasterFreight,
        "SaleMaster_SubTotalAmount": saleMasterSubTotalAmount,
        "shipping_charge": shippingCharge,
        "cashPaid": cashPaid,
        "bankPaid": bankPaid,
        "bank_id": bankId,
        "transaction_id": transactionId,
        "SaleMaster_PaidAmount": saleMasterPaidAmount,
        "SaleMaster_DueAmount": saleMasterDueAmount,
        "SaleMaster_Previous_Due": saleMasterPreviousDue,
        "returnAmount": returnAmount,
        "exchange_amount": exchangeAmount,
        "promotional_discount": promotionalDiscount,
        "special_discount": specialDiscount,
        "sale_point": salePoint,
        "use_point": usePoint,
        "status": status,
        "AddBy": addBy,
        "created_at": createdAt,
        "UpdateBy": updateBy,
        "updated_at": updatedAt,
        "DeletedBy": deletedBy,
        "DeletedTime": deletedTime,
        "last_update_ip": lastUpdateIp,
        "warehouse_id": warehouseId,
        "branch_id": branchId,
        "order_details": List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
    };
}

class OrderDetail {
    final dynamic saleDetailsSlNo;
    final dynamic saleMasterIdNo;
    final dynamic productIdNo;
    final dynamic productType;
    final dynamic saleDetailsTotalQuantity;
    final dynamic purchaseRate;
    final dynamic saleDetailsRate;
    final dynamic offerPrice;
    final dynamic offerQuantity;
    final dynamic promoDiscountId;
    final dynamic saleDetailsDiscount;
    final dynamic discountAmount;
    final dynamic saleDetailsTax;
    final dynamic vatAmount;
    final dynamic sd;
    final dynamic sdAmount;
    final dynamic saleDetailsTotalAmount;
    final dynamic isService;
    final dynamic isFree;
    final dynamic status;
    final dynamic addBy;
    final dynamic createdAt;
    final dynamic updateBy;
    final dynamic updatedAt;
    final dynamic deletedBy;
    final dynamic deletedTime;
    final dynamic lastUpdateIp;
    final dynamic warehouseId;
    final dynamic branchId;

    OrderDetail({
        required this.saleDetailsSlNo,
        required this.saleMasterIdNo,
        required this.productIdNo,
        required this.productType,
        required this.saleDetailsTotalQuantity,
        required this.purchaseRate,
        required this.saleDetailsRate,
        required this.offerPrice,
        required this.offerQuantity,
        required this.promoDiscountId,
        required this.saleDetailsDiscount,
        required this.discountAmount,
        required this.saleDetailsTax,
        required this.vatAmount,
        required this.sd,
        required this.sdAmount,
        required this.saleDetailsTotalAmount,
        required this.isService,
        required this.isFree,
        required this.status,
        required this.addBy,
        required this.createdAt,
        required this.updateBy,
        required this.updatedAt,
        required this.deletedBy,
        required this.deletedTime,
        required this.lastUpdateIp,
        required this.warehouseId,
        required this.branchId,
    });

    factory OrderDetail.fromJson(String str) => OrderDetail.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrderDetail.fromMap(Map<String, dynamic> json) => OrderDetail(
        saleDetailsSlNo: json["SaleDetails_SlNo"],
        saleMasterIdNo: json["SaleMaster_IDNo"],
        productIdNo: json["Product_IDNo"],
        productType: json["Product_Type"],
        saleDetailsTotalQuantity: json["SaleDetails_TotalQuantity"],
        purchaseRate: json["Purchase_Rate"],
        saleDetailsRate: json["SaleDetails_Rate"],
        offerPrice: json["offer_price"],
        offerQuantity: json["offer_quantity"],
        promoDiscountId: json["promo_discount_id"],
        saleDetailsDiscount: json["SaleDetails_Discount"],
        discountAmount: json["Discount_amount"],
        saleDetailsTax: json["SaleDetails_Tax"],
        vatAmount: json["vat_amount"],
        sd: json["sd"],
        sdAmount: json["sd_amount"],
        saleDetailsTotalAmount: json["SaleDetails_TotalAmount"],
        isService: json["is_service"],
        isFree: json["is_free"],
        status: json["status"],
        addBy: json["AddBy"],
        createdAt: json["created_at"],
        updateBy: json["UpdateBy"],
        updatedAt: json["updated_at"],
        deletedBy: json["DeletedBy"],
        deletedTime: json["DeletedTime"],
        lastUpdateIp: json["last_update_ip"],
        warehouseId: json["warehouse_id"],
        branchId: json["branch_id"],
    );

    Map<String, dynamic> toMap() => {
        "SaleDetails_SlNo": saleDetailsSlNo,
        "SaleMaster_IDNo": saleMasterIdNo,
        "Product_IDNo": productIdNo,
        "Product_Type": productType,
        "SaleDetails_TotalQuantity": saleDetailsTotalQuantity,
        "Purchase_Rate": purchaseRate,
        "SaleDetails_Rate": saleDetailsRate,
        "offer_price": offerPrice,
        "offer_quantity": offerQuantity,
        "promo_discount_id": promoDiscountId,
        "SaleDetails_Discount": saleDetailsDiscount,
        "Discount_amount": discountAmount,
        "SaleDetails_Tax": saleDetailsTax,
        "vat_amount": vatAmount,
        "sd": sd,
        "sd_amount": sdAmount,
        "SaleDetails_TotalAmount": saleDetailsTotalAmount,
        "is_service": isService,
        "is_free": isFree,
        "status": status,
        "AddBy": addBy,
        "created_at": createdAt,
        "UpdateBy": updateBy,
        "updated_at": updatedAt,
        "DeletedBy": deletedBy,
        "DeletedTime": deletedTime,
        "last_update_ip": lastUpdateIp,
        "warehouse_id": warehouseId,
        "branch_id": branchId,
    };
}














// import 'dart:convert';

// class CustomerOrdersModel {
//     final dynamic saleMasterSlNo;
//     final dynamic saleMasterInvoiceNo;
//     final dynamic salseCustomerIdNo;
//     final dynamic saleCustomerType;
//     final dynamic saleCustomerName;
//     final dynamic saleCustomerMobile;
//     final dynamic saleCustomerAddress;
//     final dynamic employeeId;
//     final dynamic saleMasterSaleDate;
//     final dynamic saleMasterDescription;
//     final dynamic saleMasterSaleType;
//     final dynamic paymentType;
//     final dynamic cashPayment;
//     final dynamic bankPayment;
//     final dynamic accountId;
//     final dynamic saleMasterTotalSaleAmount;
//     final dynamic saleMasterTotalDiscountAmount;
//     final dynamic saleMasterTaxAmount;
//     final dynamic saleMasterFreight;
//     final dynamic saleMasterSubTotalAmount;
//     final dynamic saleMasterPaidAmount;
//     final dynamic saleMasterDueAmount;
//     final dynamic saleMasterPreviousDue;
//     final dynamic status;
//     final dynamic isService;
//     final dynamic addBy;
//     final dynamic addTime;
//     final dynamic updateBy;
//     final dynamic updateTime;
//     final dynamic lastUpdateIp;
//     final dynamic saleMasterBranchid;
//     final CustomerInfo? customerInfo;
//     final List<ProductInfo>? productInfo;

//     CustomerOrdersModel({
//         required this.saleMasterSlNo,
//         required this.saleMasterInvoiceNo,
//         required this.salseCustomerIdNo,
//         required this.saleCustomerType,
//         required this.saleCustomerName,
//         required this.saleCustomerMobile,
//         required this.saleCustomerAddress,
//         required this.employeeId,
//         required this.saleMasterSaleDate,
//         required this.saleMasterDescription,
//         required this.saleMasterSaleType,
//         required this.paymentType,
//         required this.cashPayment,
//         required this.bankPayment,
//         required this.accountId,
//         required this.saleMasterTotalSaleAmount,
//         required this.saleMasterTotalDiscountAmount,
//         required this.saleMasterTaxAmount,
//         required this.saleMasterFreight,
//         required this.saleMasterSubTotalAmount,
//         required this.saleMasterPaidAmount,
//         required this.saleMasterDueAmount,
//         required this.saleMasterPreviousDue,
//         required this.status,
//         required this.isService,
//         required this.addBy,
//         required this.addTime,
//         required this.updateBy,
//         required this.updateTime,
//         required this.lastUpdateIp,
//         required this.saleMasterBranchid,
//         required this.customerInfo,
//         required this.productInfo,
//     });

//     factory CustomerOrdersModel.fromJson(String str) => CustomerOrdersModel.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory CustomerOrdersModel.fromMap(Map<String, dynamic> json) => CustomerOrdersModel(
//         saleMasterSlNo: json["SaleMaster_SlNo"],
//         saleMasterInvoiceNo: json["SaleMaster_InvoiceNo"],
//         salseCustomerIdNo: json["SalseCustomer_IDNo"],
//         saleCustomerType: json["SaleCustomer_Type"],
//         saleCustomerName: json["SaleCustomer_Name"],
//         saleCustomerMobile: json["SaleCustomer_Mobile"],
//         saleCustomerAddress: json["SaleCustomer_Address"],
//         employeeId: json["employee_id"],
//         saleMasterSaleDate: json["SaleMaster_SaleDate"],
//         saleMasterDescription: json["SaleMaster_Description"],
//         saleMasterSaleType: json["SaleMaster_SaleType"],
//         paymentType: json["payment_type"],
//         cashPayment: json["cash_payment"],
//         bankPayment: json["bank_payment"],
//         accountId: json["account_id"],
//         saleMasterTotalSaleAmount: json["SaleMaster_TotalSaleAmount"],
//         saleMasterTotalDiscountAmount: json["SaleMaster_TotalDiscountAmount"],
//         saleMasterTaxAmount: json["SaleMaster_TaxAmount"],
//         saleMasterFreight: json["SaleMaster_Freight"],
//         saleMasterSubTotalAmount: json["SaleMaster_SubTotalAmount"],
//         saleMasterPaidAmount: json["SaleMaster_PaidAmount"],
//         saleMasterDueAmount: json["SaleMaster_DueAmount"],
//         saleMasterPreviousDue: json["SaleMaster_Previous_Due"],
//         status: json["Status"],
//         isService: json["is_service"],
//         addBy: json["AddBy"],
//         addTime: json["AddTime"],
//         updateBy: json["UpdateBy"],
//         updateTime: json["UpdateTime"],
//         lastUpdateIp: json["last_update_ip"],
//         saleMasterBranchid: json["SaleMaster_branchid"],
//         customerInfo: json["customer_info"] == null ? null : CustomerInfo.fromMap(json["customer_info"]),
//         productInfo: json["product_info"]== null || json["product_info"]==[] ? [] : List<ProductInfo>.from(json["product_info"].map((x) => ProductInfo.fromMap(x))),
//     );

//     Map<String, dynamic> toMap() => {
//         "SaleMaster_SlNo": saleMasterSlNo,
//         "SaleMaster_InvoiceNo": saleMasterInvoiceNo,
//         "SalseCustomer_IDNo": salseCustomerIdNo,
//         "SaleCustomer_Type": saleCustomerType,
//         "SaleCustomer_Name": saleCustomerName,
//         "SaleCustomer_Mobile": saleCustomerMobile,
//         "SaleCustomer_Address": saleCustomerAddress,
//         "employee_id": employeeId,
//         "SaleMaster_SaleDate": saleMasterSaleDate,
//         "SaleMaster_Description": saleMasterDescription,
//         "SaleMaster_SaleType": saleMasterSaleType,
//         "payment_type": paymentType,
//         "cash_payment": cashPayment,
//         "bank_payment": bankPayment,
//         "account_id": accountId,
//         "SaleMaster_TotalSaleAmount": saleMasterTotalSaleAmount,
//         "SaleMaster_TotalDiscountAmount": saleMasterTotalDiscountAmount,
//         "SaleMaster_TaxAmount": saleMasterTaxAmount,
//         "SaleMaster_Freight": saleMasterFreight,
//         "SaleMaster_SubTotalAmount": saleMasterSubTotalAmount,
//         "SaleMaster_PaidAmount": saleMasterPaidAmount,
//         "SaleMaster_DueAmount": saleMasterDueAmount,
//         "SaleMaster_Previous_Due": saleMasterPreviousDue,
//         "Status": status,
//         "is_service": isService,
//         "AddBy": addBy,
//         "AddTime": addTime,
//         "UpdateBy": updateBy,
//         "UpdateTime": updateTime,
//         "last_update_ip": lastUpdateIp,
//         "SaleMaster_branchid": saleMasterBranchid,
//         "customer_info": customerInfo?.toMap(),
//         "product_info": List<dynamic>.from(productInfo!.map((x) => x.toJson())),
//     };
// }

// class CustomerInfo {
//     final dynamic customerSlNo;
//     final dynamic customerCode;
//     final dynamic customerName;
//     final dynamic lastName;
//     final dynamic password;
//     final dynamic customerType;
//     final dynamic customerPhone;
//     final dynamic customerMobile;
//     final dynamic customerEmail;
//     final dynamic customerOfficePhone;
//     final dynamic customerAddress;
//     final dynamic customerBirthday;
//     final dynamic customerMarriageDay;
//     final dynamic ownerName;
//     final dynamic referenceDetails;
//     final dynamic countrySlNo;
//     final dynamic areaId;
//     final dynamic customerWeb;
//     final dynamic customerCreditLimit;
//     final dynamic previousDue;
//     final dynamic imageName;
//     final dynamic status;
//     final dynamic isBlacklist;
//     final dynamic blacklistNote;
//     final dynamic addBy;
//     final dynamic addTime;
//     final dynamic updateBy;
//     final dynamic updateTime;
//     final dynamic lastUpdateIp;
//     final dynamic customerBranchid;

//     CustomerInfo({
//         required this.customerSlNo,
//         required this.customerCode,
//         required this.customerName,
//         required this.lastName,
//         required this.password,
//         required this.customerType,
//         required this.customerPhone,
//         required this.customerMobile,
//         required this.customerEmail,
//         required this.customerOfficePhone,
//         required this.customerAddress,
//         required this.customerBirthday,
//         required this.customerMarriageDay,
//         required this.ownerName,
//         required this.referenceDetails,
//         required this.countrySlNo,
//         required this.areaId,
//         required this.customerWeb,
//         required this.customerCreditLimit,
//         required this.previousDue,
//         required this.imageName,
//         required this.status,
//         required this.isBlacklist,
//         required this.blacklistNote,
//         required this.addBy,
//         required this.addTime,
//         required this.updateBy,
//         required this.updateTime,
//         required this.lastUpdateIp,
//         required this.customerBranchid,
//     });

//     factory CustomerInfo.fromJson(String str) => CustomerInfo.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory CustomerInfo.fromMap(Map<String, dynamic> json) => CustomerInfo(
//         customerSlNo: json["Customer_SlNo"],
//         customerCode: json["Customer_Code"],
//         customerName: json["Customer_Name"],
//         lastName: json["last_name"],
//         password: json["password"],
//         customerType: json["Customer_Type"],
//         customerPhone: json["Customer_Phone"],
//         customerMobile: json["Customer_Mobile"],
//         customerEmail: json["Customer_Email"],
//         customerOfficePhone: json["Customer_OfficePhone"],
//         customerAddress: json["Customer_Address"],
//         customerBirthday: json["Customer_Birthday"],
//         customerMarriageDay: json["Customer_MarriageDay"],
//         ownerName: json["owner_name"],
//         referenceDetails: json["reference_details"],
//         countrySlNo: json["Country_SlNo"],
//         areaId: json["area_ID"],
//         customerWeb: json["Customer_Web"],
//         customerCreditLimit: json["Customer_Credit_Limit"],
//         previousDue: json["previous_due"],
//         imageName: json["image_name"],
//         status: json["status"],
//         isBlacklist: json["is_blacklist"],
//         blacklistNote: json["blacklist_note"],
//         addBy: json["AddBy"],
//         addTime: json["AddTime"],
//         updateBy: json["UpdateBy"],
//         updateTime: json["UpdateTime"],
//         lastUpdateIp: json["last_update_ip"],
//         customerBranchid: json["Customer_branchid"],
//     );

//     Map<String, dynamic> toMap() => {
//         "Customer_SlNo": customerSlNo,
//         "Customer_Code": customerCode,
//         "Customer_Name": customerName,
//         "last_name": lastName,
//         "password": password,
//         "Customer_Type": customerType,
//         "Customer_Phone": customerPhone,
//         "Customer_Mobile": customerMobile,
//         "Customer_Email": customerEmail,
//         "Customer_OfficePhone": customerOfficePhone,
//         "Customer_Address": customerAddress,
//         "Customer_Birthday": customerBirthday,
//         "Customer_MarriageDay": customerMarriageDay,
//         "owner_name": ownerName,
//         "reference_details": referenceDetails,
//         "Country_SlNo": countrySlNo,
//         "area_ID": areaId,
//         "Customer_Web": customerWeb,
//         "Customer_Credit_Limit": customerCreditLimit,
//         "previous_due": previousDue,
//         "image_name": imageName,
//         "status": status,
//         "is_blacklist": isBlacklist,
//         "blacklist_note": blacklistNote,
//         "AddBy": addBy,
//         "AddTime": addTime,
//         "UpdateBy": updateBy,
//         "UpdateTime": updateTime,
//         "last_update_ip": lastUpdateIp,
//         "Customer_branchid": customerBranchid,
//     };
// }

// class ProductInfo {
//     final dynamic saleDetailsSlNo;
//     final dynamic saleMasterIdNo;
//     final dynamic productIdNo;
//     final dynamic saleDetailsTotalQuantity;
//     final dynamic purchaseRate;
//     final dynamic saleDetailsRate;
//     final dynamic saleDetailsSubTotalAmount;
//     final dynamic saleDetailsDiscount;
//     final dynamic discountAmount;
//     final dynamic saleDetailsTax;
//     final dynamic saleDetailsTotalAmount;
//     final dynamic warranty;
//     final dynamic status;
//     final dynamic addBy;
//     final dynamic addTime;
//     final dynamic updateBy;
//     final dynamic updateTime;
//     final dynamic lastUpdateIp;
//     final dynamic saleDetailsBranchId;
//     final RelToProduct? relToProduct;

//     ProductInfo({
//         required this.saleDetailsSlNo,
//         required this.saleMasterIdNo,
//         required this.productIdNo,
//         required this.saleDetailsTotalQuantity,
//         required this.purchaseRate,
//         required this.saleDetailsRate,
//         required this.saleDetailsSubTotalAmount,
//         required this.saleDetailsDiscount,
//         required this.discountAmount,
//         required this.saleDetailsTax,
//         required this.saleDetailsTotalAmount,
//         required this.warranty,
//         required this.status,
//         required this.addBy,
//         required this.addTime,
//         required this.updateBy,
//         required this.updateTime,
//         required this.lastUpdateIp,
//         required this.saleDetailsBranchId,
//         required this.relToProduct,
//     });

//     factory ProductInfo.fromJson(String str) => ProductInfo.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory ProductInfo.fromMap(Map<String, dynamic> json) => ProductInfo(
//         saleDetailsSlNo: json["SaleDetails_SlNo"],
//         saleMasterIdNo: json["SaleMaster_IDNo"],
//         productIdNo: json["Product_IDNo"],
//         saleDetailsTotalQuantity: json["SaleDetails_TotalQuantity"],
//         purchaseRate: json["Purchase_Rate"],
//         saleDetailsRate: json["SaleDetails_Rate"],
//         saleDetailsSubTotalAmount: json["SaleDetails_SubTotalAmount"],
//         saleDetailsDiscount: json["SaleDetails_Discount"],
//         discountAmount: json["Discount_amount"],
//         saleDetailsTax: json["SaleDetails_Tax"],
//         saleDetailsTotalAmount: json["SaleDetails_TotalAmount"],
//         warranty: json["warranty"],
//         status: json["Status"],
//         addBy: json["AddBy"],
//         addTime: json["AddTime"],
//         updateBy: json["UpdateBy"],
//         updateTime: json["UpdateTime"],
//         lastUpdateIp: json["last_update_ip"],
//         saleDetailsBranchId: json["SaleDetails_BranchId"],
//         relToProduct: json["rel_to_product"] == null ? null :  RelToProduct.fromMap(json["rel_to_product"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "SaleDetails_SlNo": saleDetailsSlNo,
//         "SaleMaster_IDNo": saleMasterIdNo,
//         "Product_IDNo": productIdNo,
//         "SaleDetails_TotalQuantity": saleDetailsTotalQuantity,
//         "Purchase_Rate": purchaseRate,
//         "SaleDetails_Rate": saleDetailsRate,
//         "SaleDetails_SubTotalAmount": saleDetailsSubTotalAmount,
//         "SaleDetails_Discount": saleDetailsDiscount,
//         "Discount_amount": discountAmount,
//         "SaleDetails_Tax": saleDetailsTax,
//         "SaleDetails_TotalAmount": saleDetailsTotalAmount,
//         "warranty": warranty,
//         "Status": status,
//         "AddBy": addBy,
//         "AddTime": addTime,
//         "UpdateBy": updateBy,
//         "UpdateTime": updateTime,
//         "last_update_ip": lastUpdateIp,
//         "SaleDetails_BranchId": saleDetailsBranchId,
//         "rel_to_product": relToProduct?.toMap(),
//     };
// }

// class RelToProduct {
//     final dynamic productSlNo;
//     final dynamic productCode;
//     final dynamic productName;
//     final dynamic productCategoryId;
//     final dynamic reference;
//     final dynamic barcode;
//     final dynamic color;
//     final dynamic brand;
//     final dynamic modelId;
//     final dynamic size;
//     final dynamic vat;
//     final dynamic productReOrederLevel;
//     final dynamic productPurchaseRate;
//     final dynamic productSellingPrice;
//     final dynamic productMinimumSellingPrice;
//     final dynamic productWholesaleRate;
//     final dynamic productCorporateRate;
//     final dynamic productOnlineRate;
//     final dynamic onlineDiscount;
//     final dynamic onlineDiscountPrice;
//     final dynamic onlineAfterDiscountAmount;
//     final dynamic startDate;
//     final dynamic oneCartunEqual;
//     final dynamic isService;
//     final dynamic isSerial;
//     final dynamic unitId;
//     final dynamic warranty;
//     final dynamic status;
//     final dynamic addBy;
//     final dynamic addTime;
//     final dynamic updateBy;
//     final dynamic updateTime;
//     final dynamic lastUpdateIp;
//     final dynamic productBranchid;
//     final dynamic model;
//     final dynamic slug;
//     final dynamic shortDescription;
//     final dynamic longDescription;
//     final dynamic specification;
//     final dynamic video;
//     final dynamic warrantyLongText;
//     final dynamic emiAvilable;
//     final dynamic isExchange;
//     final dynamic isFeature;
//     final dynamic isBestDeal;
//     final dynamic isBestSallers;
//     final dynamic newArrival;
//     final dynamic isOffer;
//     final dynamic type;
//     final dynamic mainImage;
//     final dynamic alterImage;
//     final dynamic mainImageAlt;
//     final dynamic alterImageAlt;
//     final dynamic weight;
//     final dynamic dimensions;
//     final dynamic note;
//     final dynamic compatibility;
//     final dynamic connectivity;
//     final dynamic noiseCancellation;
//     final dynamic microphone;
//     final dynamic waterResistance;
//     final dynamic powerOutput;
//     final dynamic frequencyResponse;
//     final dynamic material;
//     final dynamic batteryCapacity;
//     final dynamic camera;
//     final dynamic network;
//     final dynamic processor;
//     final dynamic ram;
//     final dynamic storage;
//     final dynamic display;
//     final dynamic batteryLife;
//     final dynamic operatingSystem;
//     final dynamic ports;
//     final dynamic cableType;
//     final dynamic length;
//     final dynamic isDraft;
//     final dynamic seoTitle;
//     final dynamic seoKeywords;
//     final dynamic seoDescription;
//     final dynamic storageId;
//     final dynamic regionId;
//     final dynamic simId;
//     final dynamic strapId;
//     final dynamic networkId;
//     final dynamic plugId;
//     final dynamic sizeId;
//     final dynamic specificationTypeId;
//     final dynamic endDate;
//     final dynamic preOrder;
//     final dynamic isTba;
//     final dynamic isCallForAvailablity;
//     final dynamic isOnlineOrder;
//     final dynamic showOnWebsite;
//     final dynamic deletedBy;
//     final dynamic deletedAt;
//     final dynamic createdAt;

//     RelToProduct({
//         required this.productSlNo,
//         required this.productCode,
//         required this.productName,
//         required this.productCategoryId,
//         required this.reference,
//         required this.barcode,
//         required this.color,
//         required this.brand,
//         required this.modelId,
//         required this.size,
//         required this.vat,
//         required this.productReOrederLevel,
//         required this.productPurchaseRate,
//         required this.productSellingPrice,
//         required this.productMinimumSellingPrice,
//         required this.productWholesaleRate,
//         required this.productCorporateRate,
//         required this.productOnlineRate,
//         required this.onlineDiscount,
//         required this.onlineDiscountPrice,
//         required this.onlineAfterDiscountAmount,
//         required this.startDate,
//         required this.oneCartunEqual,
//         required this.isService,
//         required this.isSerial,
//         required this.unitId,
//         required this.warranty,
//         required this.status,
//         required this.addBy,
//         required this.addTime,
//         required this.updateBy,
//         required this.updateTime,
//         required this.lastUpdateIp,
//         required this.productBranchid,
//         required this.model,
//         required this.slug,
//         required this.shortDescription,
//         required this.longDescription,
//         required this.specification,
//         required this.video,
//         required this.warrantyLongText,
//         required this.emiAvilable,
//         required this.isExchange,
//         required this.isFeature,
//         required this.isBestDeal,
//         required this.isBestSallers,
//         required this.newArrival,
//         required this.isOffer,
//         required this.type,
//         required this.mainImage,
//         required this.alterImage,
//         required this.mainImageAlt,
//         required this.alterImageAlt,
//         required this.weight,
//         required this.dimensions,
//         required this.note,
//         required this.compatibility,
//         required this.connectivity,
//         required this.noiseCancellation,
//         required this.microphone,
//         required this.waterResistance,
//         required this.powerOutput,
//         required this.frequencyResponse,
//         required this.material,
//         required this.batteryCapacity,
//         required this.camera,
//         required this.network,
//         required this.processor,
//         required this.ram,
//         required this.storage,
//         required this.display,
//         required this.batteryLife,
//         required this.operatingSystem,
//         required this.ports,
//         required this.cableType,
//         required this.length,
//         required this.isDraft,
//         required this.seoTitle,
//         required this.seoKeywords,
//         required this.seoDescription,
//         required this.storageId,
//         required this.regionId,
//         required this.simId,
//         required this.strapId,
//         required this.networkId,
//         required this.plugId,
//         required this.sizeId,
//         required this.specificationTypeId,
//         required this.endDate,
//         required this.preOrder,
//         required this.isTba,
//         required this.isCallForAvailablity,
//         required this.isOnlineOrder,
//         required this.showOnWebsite,
//         required this.deletedBy,
//         required this.deletedAt,
//         required this.createdAt,
//     });

//     factory RelToProduct.fromJson(String str) => RelToProduct.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory RelToProduct.fromMap(Map<String, dynamic> json) => RelToProduct(
//         productSlNo: json["Product_SlNo"],
//         productCode: json["Product_Code"],
//         productName: json["Product_Name"],
//         productCategoryId: json["ProductCategory_ID"],
//         reference: json["reference"],
//         barcode: json["barcode"],
//         color: json["color"],
//         brand: json["brand"],
//         modelId: json["model_id"],
//         size: json["size"],
//         vat: json["vat"],
//         productReOrederLevel: json["Product_ReOrederLevel"],
//         productPurchaseRate: json["Product_Purchase_Rate"],
//         productSellingPrice: json["Product_SellingPrice"],
//         productMinimumSellingPrice: json["Product_MinimumSellingPrice"],
//         productWholesaleRate: json["Product_WholesaleRate"],
//         productCorporateRate: json["Product_CorporateRate"],
//         productOnlineRate: json["Product_OnlineRate"],
//         onlineDiscount: json["online_discount"],
//         onlineDiscountPrice: json["online_discount_price"],
//         onlineAfterDiscountAmount: json["online_after_discount_amount"],
//         startDate: json["start_date"],
//         oneCartunEqual: json["one_cartun_equal"],
//         isService: json["is_service"],
//         isSerial: json["is_serial"],
//         unitId: json["Unit_ID"],
//         warranty: json["warranty"],
//         status: json["status"],
//         addBy: json["AddBy"],
//         addTime: json["AddTime"],
//         updateBy: json["UpdateBy"],
//         updateTime: json["UpdateTime"],
//         lastUpdateIp: json["last_update_ip"],
//         productBranchid: json["Product_branchid"],
//         model: json["model"],
//         slug: json["slug"],
//         shortDescription: json["short_description"],
//         longDescription: json["long_description"],
//         specification: json["specification"],
//         video: json["video"],
//         warrantyLongText: json["warranty_long_text"],
//         emiAvilable: json["emi_avilable"],
//         isExchange: json["is_exchange"],
//         isFeature: json["is_feature"],
//         isBestDeal: json["is_best_deal"],
//         isBestSallers: json["is_best_sallers"],
//         newArrival: json["new_arrival"],
//         isOffer: json["is_offer"],
//         type: json["type"],
//         mainImage: json["main_image"],
//         alterImage: json["alter_image"],
//         mainImageAlt: json["main_image_alt"],
//         alterImageAlt: json["alter_image_alt"],
//         weight: json["weight"],
//         dimensions: json["dimensions"],
//         note: json["note"],
//         compatibility: json["compatibility"],
//         connectivity: json["connectivity"],
//         noiseCancellation: json["noise_cancellation"],
//         microphone: json["microphone"],
//         waterResistance: json["water_resistance"],
//         powerOutput: json["power_output"],
//         frequencyResponse: json["frequency_response"],
//         material: json["material"],
//         batteryCapacity: json["battery_capacity"],
//         camera: json["camera"],
//         network: json["network"],
//         processor: json["processor"],
//         ram: json["ram"],
//         storage: json["storage"],
//         display: json["display"],
//         batteryLife: json["battery_life"],
//         operatingSystem: json["operating_system"],
//         ports: json["ports"],
//         cableType: json["cable_type"],
//         length: json["length"],
//         isDraft: json["is_draft"],
//         seoTitle: json["seoTitle"],
//         seoKeywords: json["seoKeywords"],
//         seoDescription: json["seoDescription"],
//         storageId: json["storage_id"],
//         regionId: json["region_id"],
//         simId: json["sim_id"],
//         strapId: json["strap_id"],
//         networkId: json["network_id"],
//         plugId: json["plug_id"],
//         sizeId: json["size_id"],
//         specificationTypeId: json["specification_type_id"],
//         endDate: json["end_date"],
//         preOrder: json["pre_order"],
//         isTba: json["is_tba"],
//         isCallForAvailablity: json["is_call_for_availablity"],
//         isOnlineOrder: json["is_online_order"],
//         showOnWebsite: json["show_on_website"],
//         deletedBy: json["deleted_by"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"],
//     );

//     Map<String, dynamic> toMap() => {
//         "Product_SlNo": productSlNo,
//         "Product_Code": productCode,
//         "Product_Name": productName,
//         "ProductCategory_ID": productCategoryId,
//         "reference": reference,
//         "barcode": barcode,
//         "color": color,
//         "brand": brand,
//         "model_id": modelId,
//         "size": size,
//         "vat": vat,
//         "Product_ReOrederLevel": productReOrederLevel,
//         "Product_Purchase_Rate": productPurchaseRate,
//         "Product_SellingPrice": productSellingPrice,
//         "Product_MinimumSellingPrice": productMinimumSellingPrice,
//         "Product_WholesaleRate": productWholesaleRate,
//         "Product_CorporateRate": productCorporateRate,
//         "Product_OnlineRate": productOnlineRate,
//         "online_discount": onlineDiscount,
//         "online_discount_price": onlineDiscountPrice,
//         "online_after_discount_amount": onlineAfterDiscountAmount,
//         "start_date": startDate,
//         "one_cartun_equal": oneCartunEqual,
//         "is_service": isService,
//         "is_serial": isSerial,
//         "Unit_ID": unitId,
//         "warranty": warranty,
//         "status": status,
//         "AddBy": addBy,
//         "AddTime": addTime,
//         "UpdateBy": updateBy,
//         "UpdateTime": updateTime,
//         "last_update_ip": lastUpdateIp,
//         "Product_branchid": productBranchid,
//         "model": model,
//         "slug": slug,
//         "short_description": shortDescription,
//         "long_description": longDescription,
//         "specification": specification,
//         "video": video,
//         "warranty_long_text": warrantyLongText,
//         "emi_avilable": emiAvilable,
//         "is_exchange": isExchange,
//         "is_feature": isFeature,
//         "is_best_deal": isBestDeal,
//         "is_best_sallers": isBestSallers,
//         "new_arrival": newArrival,
//         "is_offer": isOffer,
//         "type": type,
//         "main_image": mainImage,
//         "alter_image": alterImage,
//         "main_image_alt": mainImageAlt,
//         "alter_image_alt": alterImageAlt,
//         "weight": weight,
//         "dimensions": dimensions,
//         "note": note,
//         "compatibility": compatibility,
//         "connectivity": connectivity,
//         "noise_cancellation": noiseCancellation,
//         "microphone": microphone,
//         "water_resistance": waterResistance,
//         "power_output": powerOutput,
//         "frequency_response": frequencyResponse,
//         "material": material,
//         "battery_capacity": batteryCapacity,
//         "camera": camera,
//         "network": network,
//         "processor": processor,
//         "ram": ram,
//         "storage": storage,
//         "display": display,
//         "battery_life": batteryLife,
//         "operating_system": operatingSystem,
//         "ports": ports,
//         "cable_type": cableType,
//         "length": length,
//         "is_draft": isDraft,
//         "seoTitle": seoTitle,
//         "seoKeywords": seoKeywords,
//         "seoDescription": seoDescription,
//         "storage_id": storageId,
//         "region_id": regionId,
//         "sim_id": simId,
//         "strap_id": strapId,
//         "network_id": networkId,
//         "plug_id": plugId,
//         "size_id": sizeId,
//         "specification_type_id": specificationTypeId,
//         "end_date": endDate,
//         "pre_order": preOrder,
//         "is_tba": isTba,
//         "is_call_for_availablity": isCallForAvailablity,
//         "is_online_order": isOnlineOrder,
//         "show_on_website": showOnWebsite,
//         "deleted_by": deletedBy,
//         "deleted_at": deletedAt,
//         "created_at": createdAt,
//     };
// }








