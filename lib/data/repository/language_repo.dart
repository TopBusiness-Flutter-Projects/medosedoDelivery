import 'package:flutter/material.dart';
import 'package:medosedoDelivery/data/model/response/language_model.dart';
import 'package:medosedoDelivery/utill/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }
}
