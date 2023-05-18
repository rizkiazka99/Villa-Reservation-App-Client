import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/data/models/auth/register_response.dart';

class RegisterScreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final emailFormKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();
  final nameFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final confirmPasswordFormKey = GlobalKey<FormState>();

  var autoValidateEmail = AutovalidateMode.disabled;
  var autoValidatePhone = AutovalidateMode.disabled;
  var autoValidateName = AutovalidateMode.disabled;
  var autoValidatePassword = AutovalidateMode.disabled;
  var autoValidateConfirmPassword = AutovalidateMode.disabled;

  RxBool _isPasswordVisible = true.obs;
  RxBool _isConfirmPasswordVisible = true.obs;
  RxBool _registerLoading = false.obs;
  Rxn<RegisterResponse> _registerData = Rxn<RegisterResponse>();

  bool get isPasswordVisible => _isPasswordVisible.value;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible.value;
  bool get registerLoading => _registerLoading.value;
  RegisterResponse? get registerData => _registerData.value;

  set isPasswordVisible(bool isPasswordVisible) => 
      this._isPasswordVisible.value = isPasswordVisible;
  set isConfirmPasswordVisible(bool isConfirmPasswordVisible) =>
      this._isConfirmPasswordVisible.value = isConfirmPasswordVisible;
  set registerLoading(bool registerLoading) =>
      this._registerLoading.value = registerLoading;
  set registerData(RegisterResponse? registerData) =>
      this._registerData.value = registerData;

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void showAndHidePassword() {
    isPasswordVisible = !isPasswordVisible;
  }

  void showAndHideConfirmPassword() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
  }

}