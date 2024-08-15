import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/app_color.dart';

showLoader(BuildContext context) async {
  return await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColor.blackColor.withOpacity(.2),
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: ()async{
            return false;
          },
          child: CustomCircularProgressIndicator(),
        );
      });
}

class CustomCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child:
                // CupertinoActivityIndicator()
                CircularProgressIndicator(
              color: AppColor.hintTextColor,
              strokeWidth: 3,
            )),
      ],
    );
  }
}
