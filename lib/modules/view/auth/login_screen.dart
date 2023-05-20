import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/modules/controller/auth/login_screen_controller.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/authentication_form.dart';
import 'package:reservilla/widgets/decorative_or.dart';
import 'package:reservilla/widgets/default_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenController controller = Get.find<LoginScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(bottom: 36),
                color: contextOrange,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.4,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35)),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Masuk',
                                style: h2(color: contextOrange),
                                textAlign: TextAlign.right),
                            Text('Ke Akun',
                                style: h2(color: contextGrey),
                                textAlign: TextAlign.right),
                            Text('Anda',
                                style: h2(color: contextOrange),
                                textAlign: TextAlign.right)
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 50, bottom: 15),
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
                          },
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Obx(() => AuthenticationForm(
                              formKey: controller.passwordFormKey,
                              autovalidateMode: controller.autoValidatePassword,
                              controller: controller.passwordController,
                              hintText: 'Password',
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: contextOrange,
                              ),
                              obscureText: controller.isPasswordVisible,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.showAndHidePassword();
                                },
                                icon: Icon(
                                  controller.isPasswordVisible == true
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: contextOrange,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Kolom password tidak boleh kosong';
                                }
                              }))),
                      Container(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: DefaultButton(
                            onTap: () {
                              Get.toNamed(dashboardScreenRoute);
                              // controller.initiateLogin();
                            },
                            color: contextOrange,
                            buttonText: 'Masuk'),
                      ),
                      decorativeOr(context),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Belum punya akun?',
                          style: bodyLg(color: contextGrey),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: DefaultButton(
                          onTap: () {
                            Get.toNamed(registerScreenRoute);
                          },
                          color: contextGrey,
                          buttonText: 'Buat Akun',
                          buttonTextColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
