import 'dart:convert';

class AllOrderModel {
  final int id;
  final int customerId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String paymentType;
  final dynamic paymentMethod;
  final dynamic transactionId;
  final String amount;
  final String totalAmount;
  final String orderNumber;
  final dynamic invoiceNo;
  final String shipCharge;
  final String orderDate;
  final String orderMonth;
  final String orderYear;
  final String confirmedDate;
  final String processingDate;
  final String pickedDate;
  final String shippedDate;
  final String deliveredDate;
  final dynamic cancelDate;
  final dynamic returnDate;
  final dynamic returnReason;
  final String status;
  final dynamic deletedAt;
  final String createdAt;
  final String updatedAt;
  final Customer customer;

  AllOrderModel({
    required this.id,
    required this.customerId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.paymentType,
    required this.paymentMethod,
    required this.transactionId,
    required this.amount,
    required this.totalAmount,
    required this.orderNumber,
    required this.invoiceNo,
    required this.shipCharge,
    required this.orderDate,
    required this.orderMonth,
    required this.orderYear,
    required this.confirmedDate,
    required this.processingDate,
    required this.pickedDate,
    required this.shippedDate,
    required this.deliveredDate,
    required this.cancelDate,
    required this.returnDate,
    required this.returnReason,
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
  });

  factory AllOrderModel.fromJson(String str) => AllOrderModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllOrderModel.fromMap(Map<String, dynamic> json) => AllOrderModel(
    id: json["id"]??0,
    customerId: json["customer_id"]??0,
    name: json["name"]??"",
    email: json["email"]??"",
    phone: json["phone"]??"",
    address: json["address"]??"",
    paymentType: json["payment_type"]??"",
    paymentMethod: json["payment_method"],
    transactionId: json["transaction_id"],
    amount: json["amount"]??"",
    totalAmount: json["total_amount"]??"",
    orderNumber: json["order_number"]??"",
    invoiceNo: json["invoice_no"],
    shipCharge: json["ship_charge"]??"",
    orderDate: json["order_date"]??"",
    orderMonth: json["order_month"]??"",
    orderYear: json["order_year"]??"",
    confirmedDate: json["confirmed_date"]??"",
    processingDate: json["processing_date"]??"",
    pickedDate: json["picked_date"]??"",
    shippedDate: json["shipped_date"]??"",
    deliveredDate: json["delivered_date"]??"",
    cancelDate: json["cancel_date"],
    returnDate: json["return_date"],
    returnReason: json["return_reason"],
    status: json["status"]??"",
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
    customer: Customer.fromMap(json["customer"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "customer_id": customerId,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "payment_type": paymentType,
    "payment_method": paymentMethod,
    "transaction_id": transactionId,
    "amount": amount,
    "total_amount": totalAmount,
    "order_number": orderNumber,
    "invoice_no": invoiceNo,
    "ship_charge": shipCharge,
    "order_date": orderDate,
    "order_month": orderMonth,
    "order_year": orderYear,
    "confirmed_date": confirmedDate,
    "processing_date": processingDate,
    "picked_date": pickedDate,
    "shipped_date": shippedDate,
    "delivered_date": deliveredDate,
    "cancel_date": cancelDate,
    "return_date": returnDate,
    "return_reason": returnReason,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "customer": customer.toMap(),
  };
}

class Customer {
  final int id;
  final String name;
  final String email;
  final String phone;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Customer.fromJson(String str) => Customer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
    id: json["id"]??0,
    name: json["name"]??"",
    email: json["email"]??"",
    phone: json["phone"]??"",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
  };
}



// import 'dart:convert';
//
// class AllOrderModel {
//   final int id;
//   final String customerId;
//   final String name;
//   final String email;
//   final String phone;
//   final String address;
//   final String paymentType;
//   final dynamic paymentMethod;
//   final dynamic transactionId;
//   final String amount;
//   final String totalAmount;
//   final String orderNumber;
//   final dynamic invoiceNo;
//   final String shipCharge;
//   final String orderDate;
//   final String orderMonth;
//   final String orderYear;
//   final dynamic confirmedDate;
//   final dynamic processingDate;
//   final dynamic pickedDate;
//   final dynamic shippedDate;
//   final dynamic deliveredDate;
//   final dynamic cancelDate;
//   final dynamic returnDate;
//   final dynamic returnReason;
//   final String status;
//   final dynamic deletedAt;
//   final String createdAt;
//   final String updatedAt;
//   final Customer customer;
//
//   AllOrderModel({
//     required this.id,
//     required this.customerId,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.address,
//     required this.paymentType,
//     required this.paymentMethod,
//     required this.transactionId,
//     required this.amount,
//     required this.totalAmount,
//     required this.orderNumber,
//     required this.invoiceNo,
//     required this.shipCharge,
//     required this.orderDate,
//     required this.orderMonth,
//     required this.orderYear,
//     required this.confirmedDate,
//     required this.processingDate,
//     required this.pickedDate,
//     required this.shippedDate,
//     required this.deliveredDate,
//     required this.cancelDate,
//     required this.returnDate,
//     required this.returnReason,
//     required this.status,
//     required this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.customer,
//   });
//
//   factory AllOrderModel.fromJson(String str) => AllOrderModel.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory AllOrderModel.fromMap(Map<String, dynamic> json) => AllOrderModel(
//     id: json["id"]??0,
//     customerId: json["customer_id"]??"",
//     name: json["name"]??"",
//     email: json["email"]??"",
//     phone: json["phone"]??"",
//     address: json["address"]??"",
//     paymentType: json["payment_type"]??"",
//     paymentMethod: json["payment_method"],
//     transactionId: json["transaction_id"],
//     amount: json["amount"]??"",
//     totalAmount: json["total_amount"]??"",
//     orderNumber: json["order_number"]??"",
//     invoiceNo: json["invoice_no"],
//     shipCharge: json["ship_charge"]??"",
//     orderDate: json["order_date"]??"",
//     orderMonth: json["order_month"]??"",
//     orderYear: json["order_year"]??"",
//     confirmedDate: json["confirmed_date"],
//     processingDate: json["processing_date"],
//     pickedDate: json["picked_date"],
//     shippedDate: json["shipped_date"],
//     deliveredDate: json["delivered_date"],
//     cancelDate: json["cancel_date"],
//     returnDate: json["return_date"],
//     returnReason: json["return_reason"],
//     status: json["status"]??"",
//     deletedAt: json["deleted_at"],
//     createdAt: json["created_at"]??"",
//     updatedAt: json["updated_at"]??"",
//     customer: Customer.fromMap(json["customer"]),
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "customer_id": customerId,
//     "name": name,
//     "email": email,
//     "phone": phone,
//     "address": address,
//     "payment_type": paymentType,
//     "payment_method": paymentMethod,
//     "transaction_id": transactionId,
//     "amount": amount,
//     "total_amount": totalAmount,
//     "order_number": orderNumber,
//     "invoice_no": invoiceNo,
//     "ship_charge": shipCharge,
//     "order_date": orderDate,
//     "order_month": orderMonth,
//     "order_year": orderYear,
//     "confirmed_date": confirmedDate,
//     "processing_date": processingDate,
//     "picked_date": pickedDate,
//     "shipped_date": shippedDate,
//     "delivered_date": deliveredDate,
//     "cancel_date": cancelDate,
//     "return_date": returnDate,
//     "return_reason": returnReason,
//     "status": status,
//     "deleted_at": deletedAt,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "customer": customer.toMap(),
//   };
// }
//
// class Customer {
//   final int id;
//   final String name;
//   final String email;
//   final String phone;
//
//   Customer({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//   });
//
//   factory Customer.fromJson(String str) => Customer.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Customer.fromMap(Map<String, dynamic> json) => Customer(
//     id: json["id"]??0,
//     name: json["name"]??"",
//     email: json["email"]??"",
//     phone: json["phone"]??"",
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "phone": phone,
//   };
// }
