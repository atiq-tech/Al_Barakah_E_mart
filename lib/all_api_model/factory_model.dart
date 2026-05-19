import 'dart:convert';

class FactoryModel {
    final dynamic branchId;
    final dynamic branchType;
    final dynamic motherBranchId;
    final dynamic branchName;
    final dynamic branchTitle;
    final dynamic branchPhone;
    final dynamic branchWebsite;
    final dynamic branchAddress;
    final dynamic branchSales;
    final dynamic addDate;
    final dynamic status;
    final dynamic addBy;
    final dynamic addTime;
    final dynamic updateBy;
    final dynamic updateTime;
    final dynamic deletedBy;
    final dynamic deletedTime;
    final dynamic lastUpdateIp;

    FactoryModel({
        required this.branchId,
        required this.branchType,
        required this.motherBranchId,
        required this.branchName,
        required this.branchTitle,
        required this.branchPhone,
        required this.branchWebsite,
        required this.branchAddress,
        required this.branchSales,
        required this.addDate,
        required this.status,
        required this.addBy,
        required this.addTime,
        required this.updateBy,
        required this.updateTime,
        required this.deletedBy,
        required this.deletedTime,
        required this.lastUpdateIp,
    });

    factory FactoryModel.fromJson(String str) => FactoryModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FactoryModel.fromMap(Map<String, dynamic> json) => FactoryModel(
        branchId: json["branch_id"],
        branchType: json["branch_type"],
        motherBranchId: json["mother_branch_id"],
        branchName: json["Branch_name"],
        branchTitle: json["Branch_title"],
        branchPhone: json["Branch_phone"],
        branchWebsite: json["Branch_website"],
        branchAddress: json["Branch_address"],
        branchSales: json["Branch_sales"],
        addDate: json["add_date"],
        status: json["status"],
        addBy: json["AddBy"],
        addTime: json["AddTime"],
        updateBy: json["UpdateBy"],
        updateTime: json["UpdateTime"],
        deletedBy: json["DeletedBy"],
        deletedTime: json["DeletedTime"],
        lastUpdateIp: json["last_update_ip"],
    );

    Map<String, dynamic> toMap() => {
        "branch_id": branchId,
        "branch_type": branchType,
        "mother_branch_id": motherBranchId,
        "Branch_name": branchName,
        "Branch_title": branchTitle,
        "Branch_phone": branchPhone,
        "Branch_website": branchWebsite,
        "Branch_address": branchAddress,
        "Branch_sales": branchSales,
        "add_date": addDate,
        "status": status,
        "AddBy": addBy,
        "AddTime": addTime,
        "UpdateBy": updateBy,
        "UpdateTime": updateTime,
        "DeletedBy": deletedBy,
        "DeletedTime": deletedTime,
        "last_update_ip": lastUpdateIp,
    };
}
