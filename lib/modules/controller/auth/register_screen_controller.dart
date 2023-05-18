import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/auth/register_response.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/default_snackbar.dart';
import 'package:reservilla/widgets/loader_dialog.dart';

class RegisterScreenController extends GetxController {
  Repository repository = Repository();

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

  Future<RegisterResponse?> signup() async {
    dynamic data = {
      'email': emailController.text,
      'phone': phoneController.text,
      'name': nameController.text,
      'password': passwordController.text
    };

    registerLoading = true;
    RegisterResponse? res = await repository.signup(data);
    registerData = res;
    registerLoading = false;

    return registerData;
  }

  initiateSignup() async {
    final isEmailValid = emailFormKey.currentState!.validate();
    final isPhoneValid = phoneFormKey.currentState!.validate();
    final isNameValid = nameFormKey.currentState!.validate();
    final isPasswordValid = passwordFormKey.currentState!.validate();
    final isConfirmPasswordValid = confirmPasswordFormKey.currentState!.validate();

    if (isEmailValid && isPhoneValid && isNameValid && isPasswordValid && isConfirmPasswordValid) {
      loaderDialog(
        const SpinKitRing(color: contextOrange), 
        'Mohon tunggu...'
      );
      await signup();

      if(registerData!.status) {
        Get.back();
        Get.offAllNamed(loginScreenRoute);
        defaultSnackbar('Akun telah dibuat!', 'Silahkan masuk ke akun Anda');
      } else {
        if (registerData!.message == 'This e-mail address has been used by another account') {
          Get.back();
          defaultSnackbar('Ups!', 'E-mail telah dipakai oleh pengguna lain');
        } else if (registerData!.message == 'This phone number has been used by another account') {
          Get.back();
          defaultSnackbar('Ups!', 'Nomor telepon telah dipakai oleh pengguna lain');
        }
      }
    } else if (!isEmailValid) {
      autoValidateEmail = AutovalidateMode.always;
    } else if (!isPhoneValid) {
      autoValidatePhone = AutovalidateMode.always;
    } else if (!isNameValid) {
      autoValidateName = AutovalidateMode.always;
    } else if (!isPasswordValid) {
      autoValidatePassword = AutovalidateMode.always;
    } else if (!isConfirmPasswordValid) {
      autoValidateConfirmPassword = AutovalidateMode.always;
    } else {
      autoValidateEmail = AutovalidateMode.always;
      autoValidatePhone = AutovalidateMode.always;
      autoValidateName = AutovalidateMode.always;
      autoValidatePassword = AutovalidateMode.always;
      autoValidateConfirmPassword = AutovalidateMode.always;
    }
  }
}