import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/provider/singup_provider.dart';
import 'package:velvot_pay/utils/utils.dart';

import '../../../helper/app_color.dart';
import '../../../helper/custom_btn.dart';
import '../../../helper/getText.dart';
import '../../../helper/images.dart';
import '../../../helper/screen_size.dart';
import '../../../utils/Constants.dart';
import '../../../widget/progess_indicator.dart';

class SetTransactionPinScreen extends StatefulWidget {
  const SetTransactionPinScreen({super.key});

  @override
  State<SetTransactionPinScreen> createState() => _SetTransactionPinScreenState();
}

class _SetTransactionPinScreenState extends State<SetTransactionPinScreen> {
  final pinController = TextEditingController();

  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  int currentIndex = 0;
  int pinLength = 6;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < pinLength; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void onNumberSelected(String number) {
    if (currentIndex < pinLength) {
      controllers[currentIndex].text = number;
      currentIndex++;
      if (currentIndex < pinLength) {
        focusNodes[currentIndex].requestFocus();
      }
    }
    String currentPin = controllers.map((controller) => controller.text).join();
    if (currentPin.length == pinLength) {
      print("currentPin...$currentPin");
    }
  }

  void onDelete() {
    if (currentIndex > 0) {
      currentIndex--;
      controllers[currentIndex].clear();
      focusNodes[currentIndex].requestFocus();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(
      builder: (context,myProvider,child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,left: 16,right: 16,bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  progressIndicator(6),
                  ScreenSize.height(2),
                  Expanded(child: SingleChildScrollView(
                    padding:const EdgeInsets.only(top: 32,bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // GestureDetector(
                        //   onTap: (){
                        //     // Navigator.pop(context);
                        //   },
                        //   child: SvgPicture.asset(Images.arrowBackImage),
                        // ),
                        // ScreenSize.height(32),
                        getText(title: 'Set Transaction Pin',
                            size: 24, fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.grayIronColor,
                            fontWeight: FontWeight.w700),
                        ScreenSize.height(7),
                        getText(title: 'Enter a 6 digit secure pin for your transactions',
                            size: 14, fontFamily: Constants.galanoGrotesqueRegular, color: const Color(0xff51525C),
                            fontWeight: FontWeight.w400),
                        ScreenSize.height(32),
                      SizedBox(
                        child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(pinLength, (index) {
                            print(index);
                            return pinTextField(index);
                          }),
                        ),
                      ),
                        ScreenSize.height(30),
                        createNumberPinWidget(myProvider)
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 25),
              child: CustomBtn(
                  title: "Verify",
                  isLoading: myProvider.isLoading,
                  onTap: () {
                  String pin = controllers.map((controller) => controller.text).join().toString();
                  if(pin.length<6){
                    Utils.showToast('Set your pin');
                  }
                  else{
                    myProvider.isLoading?null:
                    myProvider.setMPinApiFunction(pin);
                  }
                  }),
            )

        );
      }
    );
  }

  createNumberPinWidget(SignupProvider provider){
    return GridView.builder(
        itemCount: 12,
        shrinkWrap: true,
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 16/10
    ),
        itemBuilder: (context,index){
          return index==9?
          Container():
          index==11?
              GestureDetector(
                onTap: onDelete,
                child: Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(Images.cancelSvg),
                ),
              ):
          GestureDetector(
            onTap: (){
              String number = index == 10 ? '0' : (index + 1).toString();
              onNumberSelected(number);
              setState(() {
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffF4F4F5),
              ),
              alignment: Alignment.center,
              child: getText(title:index==10?'0': (index+1).toString(),
                  size: 24, fontFamily: Constants.galanoGrotesqueMedium,
                  color: const Color(0xff26272B), fontWeight: FontWeight.w500),
            ),
          );
        });
  }

  pinTextField(index){
    return Expanded(
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
          readOnly: true,
          controller: controllers[index],
          focusNode: focusNodes[index],
          keyboardType: TextInputType.none, // Disable keyboard
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: AppColor.grayIronColor,
              fontFamily: Constants.galanoGrotesqueRegular),

          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: const Color(0xffF4F4F5),
            border: OutlineInputBorder(
                borderSide:const BorderSide(color:  Color(0xffF4F4F5), width: 1),
                borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
                borderSide:const BorderSide(color:  Color(0xffF4F4F5), width: 1),
                borderRadius: BorderRadius.circular(8)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.redColor, width: 1),
                borderRadius: BorderRadius.circular(8)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.redColor, width: 1),
                borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderSide:const BorderSide(color: AppColor.appColor, width: 1),
                borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }

}
