import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/helpers/regex.dart';
import 'package:reservilla/modules/controller/auth/register_screen_controller.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/authentication_form.dart';
import 'package:reservilla/widgets/confirmation_dialog.dart';
import 'package:reservilla/widgets/default_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenController controller = Get.find<RegisterScreenController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (controller.emailController.text.isNotEmpty || controller.phoneController.text.isNotEmpty ||
                controller.nameController.text.isNotEmpty || controller.passwordController.text.isNotEmpty ||
                controller.confirmPasswordController.text.isNotEmpty) {
            Get.dialog(
              ConfirmationDialog(
                title: 'Tunggu sebentar!', 
                content: 'Apakah Anda yakin ingin membatalkan proses pembuatan akun?', 
                onConfirmation: () {
                  Get.offAllNamed(loginScreenRoute);
                }
              )
            );

            return Future.value(false);
        } else {
          Get.offAllNamed(loginScreenRoute);
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: contextOrange,
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 10),
                  color: contextOrange,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/logo.png'
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35)
                    )
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Buat',
                                style: h2(color: contextGrey),
                                textAlign: TextAlign.left,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Akun',
                                    style: h2(color: contextOrange),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    ' Anda',
                                    style: h2(color: contextGrey),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 35, bottom: 15),
                                child: AuthenticationForm(
                                  formKey: controller.emailFormKey, 
                                  autovalidateMode: controller.autoValidateEmail, 
                                  controller: controller.emailController, 
                                  hintText: 'E-mail', 
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: contextOrange,
                                  ),
                                  validator: (value) {
                                    bool validate = EmailValidator.validate(value!);
    
                                    if (value.isEmpty) {
                                      return 'Kolom e-mail tidak boleh kosong';
                                    } else {
                                      if (!validate) {
                                        return 'E-mail tidak valid';
                                      }
                                    }
                                  }
                                )
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: AuthenticationForm(
                                  formKey: controller.phoneFormKey, 
                                  autovalidateMode: controller.autoValidatePhone, 
                                  controller: controller.phoneController, 
                                  hintText: 'Nomor Telepon',
                                  input: TextInputType.phone,
                                  prefixIcon: const Icon(
                                    Icons.phone,
                                    color: contextOrange,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Kolom nomor telepon tidak boleh kosong';
                                    } else {
                                      if (value.length > 13) {
                                        return 'Nomor telepon tidak boleh lebih dari 13 digit';
                                      } else if (value.length < 10) {
                                        return 'Nomor telepon tidak boleh kurang dari 10 digit';
                                      } else if (value[0] != '0' && value[1] != '8') {
                                        return 'Nomor telepon tidak valid. Tolong ikuti format "08xxxxxxxx"';
                                      }
                                    }
                                  }
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: AuthenticationForm(
                                  formKey: controller.nameFormKey, 
                                  autovalidateMode: controller.autoValidateName, 
                                  controller: controller.nameController, 
                                  hintText: 'Nama', 
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: contextOrange,
                                  ),
                                  validator: (value) {
                                    bool validate = CustomRegEx.validateOnlyLetters(value!);
    
                                    if (value.isEmpty) {
                                      return 'Kolom nama tidak boleh kosong';
                                    } else {
                                      if (!validate) {
                                        return 'Nama hanya boleh terdiri dari karakter huruf A-Z atau a-z';
                                      }
                                    }
                                  }
                                )
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Obx(() => AuthenticationForm(
                                  formKey: controller.passwordFormKey, 
                                  autovalidateMode: controller.autoValidatePassword,
                                  controller: controller.passwordController, 
                                  hintText: 'Password',
                                  obscureText: controller.isPasswordVisible,
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: contextOrange,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.showAndHidePassword();
                                    },
                                    icon: Icon(
                                      controller.isPasswordVisible ? Icons.visibility :
                                        Icons.visibility_off,
                                      color: contextOrange
                                    ),
                                  ),
                                  validator: (value) {
                                    bool validate = CustomRegEx.validatePassword(value!);
    
                                    if (value.isEmpty) {
                                      return 'Kolom password tidak boleh kosong';
                                    } else {
                                      if (!validate) {
                                        return 'Password harus terdiri dari 8 katakter, 1 huruf besar, 1 huruf kecil dan 1 angka';
                                      }
                                    }
                                  }
                                ),
                              )),
                              Container(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Obx(() => AuthenticationForm(
                                  formKey: controller.confirmPasswordFormKey, 
                                  autovalidateMode: controller.autoValidateConfirmPassword,
                                  controller: controller.confirmPasswordController, 
                                  hintText: 'Konfirmasi Password',
                                  obscureText: controller.isConfirmPasswordVisible,
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: contextOrange,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.showAndHideConfirmPassword();
                                    },
                                    icon: Icon(
                                      controller.isConfirmPasswordVisible ? Icons.visibility :
                                        Icons.visibility_off,
                                      color: contextOrange
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Kolom konfirmasi password tidak boleh kosong';
                                    } else {
                                      if (value != controller.passwordController.text) {
                                        return 'Password tidak terkonfirmasi';
                                      }
                                    }
                                  }
                                ),
                              )),
                              DefaultButton(
                                onTap: () {
                                  controller.initiateSignup();
                                }, 
                                color: contextOrange, 
                                buttonText: 'Buat Akun'
                              ),
                              const SizedBox(height: 15),
                              DefaultButton(
                                onTap: () {
                                  if (controller.emailController.text.isNotEmpty || controller.phoneController.text.isNotEmpty ||
                                          controller.nameController.text.isNotEmpty || controller.passwordController.text.isNotEmpty ||
                                          controller.confirmPasswordController.text.isNotEmpty) {
                                      Get.dialog(
                                        ConfirmationDialog(
                                          title: 'Tunggu sebentar!', 
                                          content: 'Apakah Anda yakin ingin membatalkan proses pembuatan akun?', 
                                          onConfirmation: () {
                                            Get.offAllNamed(loginScreenRoute);
                                          }
                                        )
                                      );
                                  } else {
                                    Get.offAllNamed(loginScreenRoute);
                                  }
                                }, 
                                color: contextRed, 
                                buttonText: 'Batal'
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}