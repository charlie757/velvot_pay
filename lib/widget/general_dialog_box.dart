
import 'package:flutter/material.dart';

import '../helper/app_color.dart';
void generalDialogBox(BuildContext context,final isDismiss, Widget content,) {
  showGeneralDialog(
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: WillPopScope(
              onWillPop: ()async{
                return isDismiss;
              },
              child: AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  backgroundColor: AppColor.whiteColor,
                  surfaceTintColor: AppColor.whiteColor,

                  shape: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.whiteColor),
                      borderRadius: BorderRadius.circular(16.0)),
                  content: content
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: isDismiss,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      });
}
