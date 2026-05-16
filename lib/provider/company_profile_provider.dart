import 'package:al_barakah_e_mart/api_integration/me/company_profile_api.dart';
import 'package:al_barakah_e_mart/model/company_profile_model.dart';
import 'package:flutter/material.dart';

class CompanyProfileProvider extends ChangeNotifier{

  CompanyProfileModel? companyProfileModel;
  getCompanyProfile() async {
    companyProfileModel = await CompanyProfileApi.fetchCompanyProfile();
    notifyListeners();
  }

}