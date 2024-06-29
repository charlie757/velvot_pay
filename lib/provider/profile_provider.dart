import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  checkValidation() {
    if (formKey.currentState!.validate()) {}
  }

  callApiFunction() {}
}
