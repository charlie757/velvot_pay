import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:velvot_pay/model/data_subscription_plan_model.dart';

import '../apiconfig/api_service.dart';
import '../apiconfig/api_url.dart';
import '../utils/show_loader.dart';
import '../utils/utils.dart';

class DataSubscriptionProvider extends ChangeNotifier{

  List<Contact>contactList= [];
  List searchList = [];
  bool noDataFound = false;
  String unknownNumber = '';

resetValues(){
  unknownNumber='';
  noDataFound=false;
  searchList.clear();
}

  Future<List<Contact>> getContactList({
    bool withProperties = true,
    bool withPhoto = true,
  }) async {
    try {
      if (await FlutterContacts.requestPermission()) {
        List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: withProperties,
          withPhoto: withPhoto,
        );
        return contacts;
      } else {
        print('Permission denied to access contacts.');
        return [];
      }
    } catch (e) {
      print('Failed to fetch contacts: $e');
      return [];
    }
  }

  Future<void> fetchContacts() async {
    contactList.isNotEmpty?null: showLoader(navigatorKey.currentContext!);
    List<Contact> contacts = await getContactList();
    contactList.isNotEmpty?null: Navigator.pop(navigatorKey.currentContext!);
      contactList = contacts;
      notifyListeners();
  }


  searchFunction(String val,)async{
    if (!contactList
        .toString()
        .toLowerCase()
        .contains(val.toLowerCase())) {
      searchList.clear();
      print('nofsfj');
      noDataFound=true;
    }
    contactList.forEach((element) {
      String lowerCaseVal = val.toLowerCase();
      String lowerCaseName = element.displayName.isNotEmpty? element.displayName.toLowerCase():"";
      String lowerCasePhone = element.phones.isNotEmpty? element.phones.first.number.toLowerCase():"";
      if (val.isEmpty) {
        unknownNumber ='';
        searchList.clear();
        noDataFound=false;
        notifyListeners();
      } else if (lowerCaseName.contains(lowerCaseVal) || lowerCasePhone.contains(lowerCaseVal)) {
        noDataFound=false;
        unknownNumber ='';
        // print("element...${element.phones.first.number}");
        searchList.add(element);
      }
     else if(val.isNotEmpty&&!lowerCasePhone.contains(lowerCaseVal)){
        unknownNumber =val;
      }
    });

    notifyListeners();
    // setState(() {});
  }

}