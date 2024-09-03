import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/custom_textfield.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/provider/transaction_provider.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/widget/appBar.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import '../../../helper/images.dart';

class DownloadStatement extends StatefulWidget {
  const DownloadStatement({super.key});

  @override
  State<DownloadStatement> createState() => _DownloadStatementState();
}

class _DownloadStatementState extends State<DownloadStatement> {

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    callDownloaderFunction();
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider = Provider.of<TransactionProvider>(context,listen: false);
    provider.resetValues();
    provider.getProfileData();
  }

  ReceivePort port = ReceivePort();
  final downloadProgress = 0;
  final currentDownloadIndex = 0;
  final pdfUrl = '';

  String downloadStatus = '';
  String? taskId;
  callDownloaderFunction() {
    IsolateNameServer.registerPortWithName(
        port.sendPort, 'downloader_send_port');
    port.listen((dynamic data) {
      int progress = data[2];
      print("progress...$progress");
      if (progress < 99 && progress > 1) {
        downloadStatus = 'running';
        print("downloadStatus...$downloadStatus");
      } else if (progress > 99) {
        downloadStatus = 'completed';
        // EasyLoading.showToast('downloading completed...',toastPosition: EasyLoadingToastPosition.bottom);
        // Platform.isAndroid?
        FlutterDownloader.open(taskId: taskId!);
        // launchURL(pdfUrl.value);
      } else {
        downloadStatus = '';
      }
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    //  flickManager==null?null:
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
    IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context,myProvider, child) {
        return Form(
          key: formKey,
          child: Scaffold(
            backgroundColor: AppColor.whiteF7Color,
            appBar: appBar(title: 'Download Account Statement',backgroundColor: AppColor.whiteF7Color),
            body: Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  periodWidget(myProvider),
                  ScreenSize.height(24),
                  emailWidget(myProvider),
                  ScreenSize.height(24),
                  addressWidget(myProvider)
                 ],
              ),
            ),
            bottomNavigationBar: Padding(padding:const EdgeInsets.only(left: 16,right: 16,bottom: 30),
            child: CustomBtn(title: 'Confirm', onTap: (){
              if(formKey.currentState!.validate()){
                myProvider.downloadStatementApiFunction().then((value) async{
                  if(value!=null){
                    String dir = (await getApplicationDocumentsDirectory()).path;
                taskId=  await FlutterDownloader.enqueue(
                  url: value['data']['url'],
                  headers: {}, // optional: header send with url (auth token etc)
                  savedDir: Platform.isAndroid
                  ? '/storage/emulated/0/Download/'
                      : "$dir/",
                  showNotification: true,
                  openFileFromNotification: true,
                  saveInPublicStorage: true,
                  );
                  }
                });
              }
            }),
            ),
          ),
        );
      }
    );
  }
  periodWidget(TransactionProvider provider){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getText(title: 'Period',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(6),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffE4E4E7))
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getText(title: 'Start Date',
                  size: 12, fontFamily: Constants.galanoGrotesqueMedium,
                  color:const Color(0xff3F3F46), fontWeight: FontWeight.w500),
              ScreenSize.height(8),
              CustomTextField(hintText: 'Select Date',isReadOnly: true,
              controller: provider.startDateController,
              suffixWidget: Container(
                width: 40,
                alignment: Alignment.centerRight,
                padding:const EdgeInsets.only(right: 14),
                child: SvgPicture.asset(Images.calendarSvg),
              ),
                onTap: (){

                provider.datePicker('Select start date',provider.initialStartDate).then((value) {
                 if(value!=null){
                   provider.initialStartDate = value;
                   var day, month, year;
                   day = value.day < 10 ? '0${value.day}' : value.day;
                   month = value.month < 10
                       ? '0${value.month}'
                       : value.month;
                   year = value.year;
                   provider.startDateController.text="${value.year}-$month-$day";
                 }
                  setState(() {
                  });
                });
                },
                validator: (val){
                if(val.isEmpty){
                  return "Select start date";
                }
                },
              ),
              ScreenSize.height(26),
              getText(title: 'End Date',
                  size: 12, fontFamily: Constants.galanoGrotesqueMedium,
                  color:const Color(0xff3F3F46), fontWeight: FontWeight.w500),
              ScreenSize.height(8),
              CustomTextField(hintText: 'Select Date',isReadOnly: true,
                controller: provider.endDateController,
                suffixWidget: Container(
                  width: 40,
                  alignment: Alignment.centerRight,
                  padding:const EdgeInsets.only(right: 14),
                  child: SvgPicture.asset(Images.calendarSvg),
                ),
                onTap: (){
                  provider.datePicker('Select end date',provider.initialEndDate).then((value) {
                    if(value!=null){
                      provider.initialEndDate = value;
                      var day, month, year;
                      day = value.day < 10 ? '0${value.day}' : value.day;
                      month = value.month < 10
                          ? '0${value.month}'
                          : value.month;
                      year = value.year;
                      provider.endDateController.text="${value.year}-$month-$day";
                    }
                    setState(() {

                    });
                  });
                },
                validator: (val){
                  if(val.isEmpty){
                    return "Select end date";
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
  emailWidget(TransactionProvider provider){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getText(title: 'Email',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(6),
        CustomTextField(hintText: 'Email',isReadOnly: true,
          fillColor: AppColor.whiteColor,
          controller: provider.emailController,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
        ),
      ],
    );
  }

  addressWidget(TransactionProvider provider){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getText(title: 'Address',
            size: 14, fontFamily: Constants.galanoGrotesqueMedium,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w500),
        ScreenSize.height(6),
        CustomTextField(hintText: 'Address',isReadOnly: true,
          fillColor: AppColor.whiteColor,
          controller: provider.addressController,
          borderColor: const Color(0xffD1D1D6),
          borderRadius: 8,
        ),
      ],
    );
  }
}
