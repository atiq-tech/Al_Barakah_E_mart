import 'dart:convert';

import 'package:al_barakah_e_mart/model/order/invoice_model.dart';
import 'package:al_barakah_e_mart/model/order/order_list_model.dart';
class OrderDetailsModel {
  final bool success;
  final List<OrderListModel> data;
  final InvoiceModel invoiceModel;

  OrderDetailsModel({
    required this.success,
    required this.data,
    required this.invoiceModel,
  });

  factory OrderDetailsModel.fromJson(String str) => OrderDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderDetailsModel.fromMap(Map<String, dynamic> json) => OrderDetailsModel(
    success: json["success"],
    data: json["orderDetails"]== [] ? [] : List<OrderListModel>.from(json["orderDetails"].map((x) => OrderListModel.fromMap(x))),
    invoiceModel: InvoiceModel.fromMap(json["orders"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "invoiceData": invoiceModel.toMap(),
  };
}