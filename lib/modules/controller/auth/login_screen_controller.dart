import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/auth/login_response.dart';
import 'package:reservilla/widgets/default_snackbar.dart';
import 'package:reservilla/widgets/loader_dialog.dart';

class LoginScreenController extends GetxController {
  Repository repository = Repository();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  var autoValidateEmail = AutovalidateMode.disabled;
  var autoValidatePassword = AutovalidateMode.disabled;

  RxBool _isPasswordVisible = true.obs;
  RxBool _loginLoading = false.obs;
  Rxn<LoginResponse> _loginData = Rxn<LoginResponse>();

  bool get isPasswordVisible => _isPasswordVisible.value;
  bool get loginLoading => _loginLoading.value;
  LoginResponse? get loginData => _loginData.value;

  set isPasswordVisible(bool isPasswordVisible) => 
      this._isPasswordVisible.value = isPasswordVisible;
  set loginLoading(bool loginLoading) =>
      this._loginLoading.value = loginLoading;
  set loginData(LoginResponse? loginData) =>
      this._loginData.value = loginData;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showAndHidePassword() {
    isPasswordVisible = !isPasswordVisible;
  }

  Future<LoginResponse?> login() async {
    dynamic data = {
      'email': emailController.text,
      'password': passwordController.text
    };

    loginLoading = true;
    LoginResponse? res = await repository.login(data);
    loginData = res;
    loginLoading = false;
    return loginData;
  }
  
  initiateLogin() async {
    final isEmailValid = emailFormKey.currentState!.validate();
    final isPasswordValid = passwordFormKey.currentState!.validate();

    if (isEmailValid && isPasswordValid) {
      loaderDialog(
        const SpinKitRing(color: contextOrange), 
        'Mohon tunggu...'
      );
      await login();

      if (loginData!.accessToken != null) {
        Get.back();
        defaultSnackbar('Ok!', 'Login berhasil');
      } else {
        if (loginData!.message == 'Invalid e-mail address or password') {
          Get.back();
          defaultSnackbar('Ups!', 'E-mail atau password salah');
        } else {
          Get.back();
          defaultSnackbar('Ups!', 'Terjadi kesalahan, mohon coba lagi');
        }
      }
    } else if (!isEmailValid) {
      autoValidateEmail = AutovalidateMode.always;
    } else if (!isPasswordValid) {
      autoValidatePassword = AutovalidateMode.always;
    } else {
      autoValidateEmail = AutovalidateMode.always;
      autoValidatePassword = AutovalidateMode.always;
    }
  }
}