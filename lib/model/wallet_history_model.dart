import 'dart:convert';

class WalletHistoryModel {
  final String sequence;
  final String id;
  final String date;
  final String description;
  final String inAmount;
  final String outAmount;
  final String balance;

  WalletHistoryModel({
    required this.sequence,
    required this.id,
    required this.date,
    required this.description,
    required this.inAmount,
    required this.outAmount,
    required this.balance,
  });

  factory WalletHistoryModel.fromJson(String str) => WalletHistoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WalletHistoryModel.fromMap(Map<String, dynamic> json) => WalletHistoryModel(
    sequence: json["sequence"]??"",
    id: json["id"]??"",
    date: json["date"]??"",
    description: json["description"]??"",
    inAmount: json["in_amount"]??"",
    outAmount: json["out_amount"]??"",
    balance: json["balance"] is int || json["balance"] is double ? json["balance"].toString() : json["balance"] ??"",
  );

  Map<String, dynamic> toMap() => {
    "sequence": sequence,
    "id": id,
    "date": date,
    "description": description,
    "in_amount": inAmount,
    "out_amount": outAmount,
    "balance": balance,
  };
}
