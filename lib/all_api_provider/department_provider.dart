import 'package:al_barakah_e_mart/all_api_model/department_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class DepartmentProvider with ChangeNotifier{
List<DepartmentModel> departmentList = [];
 getDepartment()async{
  departmentList = await AllApiService.fetchDepartment();
  notifyListeners();
 }
}