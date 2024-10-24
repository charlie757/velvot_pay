// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:velvot_pay/approutes/app_routes.dart';
// import 'package:velvot_pay/helper/app_color.dart';
// import 'package:velvot_pay/model/hospital_model.dart';
// import 'package:velvot_pay/screens/dashboard/home/choose_plan_screen.dart';
// import 'package:velvot_pay/screens/dashboard/home/pay_screen.dart';
// import 'package:velvot_pay/utils/show_loader.dart';

// import '../apiconfig/api_service.dart';
// import '../apiconfig/api_url.dart';
// import '../utils/utils.dart';

// class BillNumberProvider extends ChangeNotifier{
//   HospitalModel? hospitalModel;
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final tVController = TextEditingController();
//   final meterNumberController = TextEditingController();
//   final typeController = TextEditingController();
//   final instituteController = TextEditingController();
//   final amountController = TextEditingController();
//   String selectedHospitalValue = '';
//   int selectedBillTypeIndex =-1;
//   int selectedHospitalIndex = -1;
//   bool noDataFound = false;
//   List searchList = [];
//   File? file;

//   changeHospital(String value, String label, int index){
//     selectedHospitalValue=value;
//     controller5.text = label;
//     selectedHospitalIndex=index;
//     notifyListeners();
//   }
//   /// insurance
//   final controller1 = TextEditingController();
//   final controller2 = TextEditingController();
//   final controller3 = TextEditingController();
//   final controller4 = TextEditingController();
//   final controller5 = TextEditingController();
//   final controller6 = TextEditingController();
//   final controller7 = TextEditingController();
//   final controller8 = TextEditingController();
//   final controller9 = TextEditingController();
//   Map data = {};


//   resetValues(){
//     tVController.clear();
//     meterNumberController.clear();
//     instituteController.clear();
//     amountController.clear();
//     typeController.clear();
//     selectedBillTypeIndex=-1;
//     selectedHospitalIndex=-1;
//     selectedHospitalValue='';
//     noDataFound=false;
//     file=null;
//     searchList.clear();
//     controller1.clear();
//     controller2.clear();
//     controller3.clear();
//     controller4.clear();
//     controller5.clear();
//     controller6.clear();
//     controller7.clear();
//     controller8.clear();
//     controller9.clear();
//     data = {};
//     formKey = GlobalKey<FormState>();
//   }

//   updateBillTypeIndex(int value){
//     selectedBillTypeIndex=value;
//     notifyListeners();
//   }

//   setMobileTopUp(String operatorImage,String operatorName, String serviceId,String minAmount,String maxAmount){
//  data = {
//   "amount": controller2.text,
//   "phone": controller1.text,
//    'operatorImage':operatorImage,
//    'operatorName':operatorName,
//    'serviceId':serviceId,
//    'minimium_amount':minAmount,
//    'maximum_amount':maxAmount
//  };
//   }

//   setThirdPartyInsuranceData(String serviceId,String operatorName,String operatorImage,String route){
//     data = {
//       'billersCode':controller1.text,
//       "Insured_Name": controller2.text,
//       "Engine_Number": controller3.text,
//       "Chasis_Number": controller4.text,
//       "Plate_Number": controller1.text,
//       "Vehicle_Make": controller5.text,
//       "Vehicle_Color": controller6.text,
//       "Vehicle_Model":controller7.text,
//       "Year_of_Make": controller8.text,
//       "Contact_Address": controller9.text,
//     };
//   }

//   setHealthInsuranceData(String serviceId,String operatorName,String operatorImage,String route){
//   data= {
//     "billersCode": controller1.text,
//     "phone": controller2.text,
//     "full_name":controller1.text,
//     "address": controller3.text,
//     "selected_hospital": controller5.text,
//     'selected_hospital_value':selectedHospitalValue,
//     "Passport_Photo":file!=null? file!.path:"",
//     "date_of_birth": controller4.text,
//     "extra_info": controller6.text,

//   };
//   }

//   setPersonalInsuranceData(String serviceId,String operatorName,String operatorImage,String route){
//     data = {
//         "billersCode": controller1.text,
//         "full_name": controller1.text,
//        "phone": controller2.text,
//         "address": controller3.text,
//         "dob": controller5.text,
//         "next_kin_name": controller1.text,
//         "next_kin_phone": controller2.text,
//         "business_occupation": controller4.text,
//     };
//   }

//   setElectricityData(String serviceId,String operatorName,String operatorImage){
//     data = {
//       'billersCode':meterNumberController.text,
//       'variation_code':typeController.text.toString().toLowerCase(),
//       'amount':amountController.text,
//       'operatorImage':operatorImage,
//       'operatorName':operatorName,
//       'serviceId':serviceId,
//     };
//   }

//   setEducationData(){
//     data={
//       'instituteNumber':instituteController.text
//     };
//   }

//   setTvData(){
//     data = {
//       'tvBillerNumber':tVController.text
//     };
//   }

//   checkValidation(String serviceId,String operatorName,String operatorImage,String minAmount,String maxAmount,  String route, String isFromSearchNumberRoute){
//     if(route=='electricity'){
//       setElectricityData(serviceId, operatorName, operatorImage);
//     }
//     else if(route=='education'){
//      setEducationData();
//     }
//     else if(route=='topup'){
//       setMobileTopUp(operatorImage, operatorName, serviceId, minAmount, maxAmount,);
//     }
//       else if(route=='tv'){
//       setTvData();
//     }
//       else if(route=='insurance-third party'){
//         setThirdPartyInsuranceData(serviceId, operatorName, operatorImage, route);
//     }
//       else if(route=='insurance-health'){
//         setHealthInsuranceData(serviceId, operatorName, operatorImage, route);
//     }
//       else if(route=='insurance-personal'){
//         setPersonalInsuranceData(serviceId, operatorName, operatorImage, route);
//     }
//       if(route=='insurance-health'){
//         if(formKey.currentState!.validate()){
//           if(file!=null){
//             AppRoutes.pushNavigation(ChoosePlanScreen(serviceId: serviceId, operatorName: operatorName, operatorImage: operatorImage,
//               data: data,isFromSearchNumberRoute: '',
//               route: route,));
//             print("data...$data");
//           }
//           else{
//             Utils.showToast("Please upload image");
//           }
//         }
//       }
//       else{
//     if(formKey.currentState!.validate()){
//       route=='electricity'||route=='topup'?
//           AppRoutes.pushNavigation(PayScreen(route: route, data: data,isFromSearchNumberRoute:isFromSearchNumberRoute)):
//       AppRoutes.pushNavigation(ChoosePlanScreen(serviceId: serviceId, operatorName: operatorName, operatorImage: operatorImage,
//         data: data,isFromSearchNumberRoute: '',
//         route: route,));
//       print("data...$data");
//     }}
//   }

//   DateTime selectedDate = DateTime.now();
//   DateTime now = DateTime.now();
//   Future datePicker() async {
//     DateTime? picked = await showDatePicker(
//         builder: (context, child) {
//           return Theme(
//             data: ThemeData(colorSchemeSeed: AppColor.btnColor),
//             child: child!,
//           );
//         },
//         helpText: "Select date of birth",
//         context: navigatorKey.currentContext!,
//         initialDate: DateTime(now.year - 18, now.month, now.day),
//         firstDate: DateTime(1800, 1),
//         lastDate: DateTime(now.year - 18, now.month, now.day));
//     if (picked != null && picked != DateTime.now()) {
//       selectedDate = picked;
//       return selectedDate;
//     }
//   }

//   void imagePicker(ImageSource source) async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? img = await picker.pickImage(
//         source: source,
//         imageQuality: 25
//     );
//     if (img == null) return;
//     file = File(img.path);
//     notifyListeners();
//   }

//   getHospitalApiFunction()async{
//     showLoader(navigatorKey.currentContext!);
//     hospitalModel=null;
//     notifyListeners();
//     var body = json.encode({});
//     final response = await ApiService.apiMethod(
//         url: ApiUrl.getHospitalUrl, body: body, method: checkApiMethod(httpMethod.get));
//     Navigator.pop(navigatorKey.currentContext!);
//     if (response != null) {
//       hospitalModel = HospitalModel.fromJson(response);
//     } else {
//     }
//     notifyListeners();
//   }
//   searchFunction(String val,)async{
//     if (!hospitalModel!.data
//         .toString()
//         .toLowerCase()
//         .contains(val.toLowerCase())) {
//       searchList.clear();
//       noDataFound=true;
//       notifyListeners();
//     }
//     hospitalModel!.data!.forEach((element) {
//       if (val.isEmpty) {
//         searchList.clear();
//         noDataFound=false;
//         notifyListeners();
//       } else if (element.label
//           .toLowerCase()
//           .contains(val.toString().toLowerCase())) {
//         noDataFound=false;
//         print("element...${element.label}");
//         searchList.add(element);
//         notifyListeners();
//       } });
//     notifyListeners();
//     // setState(() {});
//   }

// }

