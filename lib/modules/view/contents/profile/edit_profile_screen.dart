import 'package:dotted_border/dotted_border.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/helpers/regex.dart';
import 'package:reservilla/modules/controller/contents/profile/edit_profile_screen_controller.dart';
import 'package:reservilla/modules/controller/miscellaneous/dashboard_screen_controller.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/back_button.dart';
import 'package:reservilla/widgets/confirmation_dialog.dart';
import 'package:reservilla/widgets/custom_form.dart';
import 'package:reservilla/widgets/default_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileScreenController controller = Get.find<EditProfileScreenController>();

  triggerModalBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        )
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkResponse(
                containedInkWell: false,
                radius: 80,
                onTap: () async {
                  Get.back();
                  await controller.getImageByCamera();
                },
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 48,
                        color: contextOrange,
                      ),
                      Text('Kamera')
                    ],
                  ),
                ),
              ),
              InkResponse(
                containedInkWell: false,
                radius: 80,
                onTap: () async {
                  Get.back();
                  await controller.getImageFromGallery();
                },
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.image,
                        size: 48,
                        color: contextOrange,
                      ),
                      Text('Galeri')
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (controller.emailController.text.isNotEmpty || controller.phoneController.text.isNotEmpty ||
                controller.nameController.text.isNotEmpty) {
            Get.dialog(
              ConfirmationDialog(
                title: 'Tunggu sebentar!', 
                content: 'Apakah Anda yakin ingin membatalkan proses pembaruan profil?', 
                onConfirmation: () {
                  Get.offAllNamed(dashboardScreenRoute);
                }
              )
            );

            return Future.value(false);
        } else {
          Get.offAllNamed(dashboardScreenRoute);
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          leading: backButton(iconColor: Colors.black),
          title: const Text('Perbarui Profil'),
          backgroundColor: contextOrange,
        ),
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
                  color: contextOrange,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 16),
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35)
                    )
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            await triggerModalBottomSheet(context);
                          },
                          child: DottedBorder(
                            strokeWidth: 2,
                            dashPattern: const [8, 4],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(15),
                            color: contextOrange,
                            child: Obx(() {
                              if (controller.picturePath.isEmpty) {
                                return Container(
                                  height: 200,
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        IconlyLight.camera,
                                        color: contextGrey,
                                      ),
                                      Text(
                                        'Tambahkan foto profil',
                                        style: h7(
                                          color: contextGrey
                                        ),
                                      )
                                    ],
                                  )
                                );
                              } else {
                                return Stack(
                                  children: [
                                    Center(
                                      child: Image.file(
                                        controller.image!,
                                        fit: BoxFit.contain
                                      )
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: TextButton(
                                        onPressed: () async {
                                          await triggerModalBottomSheet(context);
                                        },
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                                          minimumSize: MaterialStateProperty.all(const Size(60, 30)),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              side: const BorderSide(color: contextOrange)
                                            )
                                          ),
                                          backgroundColor: MaterialStateProperty.all(Colors.white)
                                        ),
                                        child: Text(
                                          'Edit',
                                          style: buttonSm(color: Colors.black),
                                        )
                                      )
                                    )
                                  ]
                                );
                              }
                            }),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: CustomForm(
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
                          child: CustomForm(
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
                          child: CustomForm(
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
                        DefaultButton(
                          onTap: () {
                            controller.initiateEditProfile();
                          }, 
                          color: contextOrange, 
                          buttonText: 'Perbarui Profil'
                        ),
                        const SizedBox(height: 15),
                        DefaultButton(
                          onTap: () {
                            if (controller.emailController.text.isNotEmpty || controller.phoneController.text.isNotEmpty ||
                                    controller.nameController.text.isNotEmpty) {
                                Get.dialog(
                                  ConfirmationDialog(
                                    title: 'Tunggu sebentar!', 
                                    content: 'Apakah Anda yakin ingin membatalkan proses pembuatan akun?', 
                                    onConfirmation: () {
                                      Get.offAllNamed(dashboardScreenRoute);
                                    }
                                  )
                                );
                            } else {
                              Get.offAllNamed(dashboardScreenRoute);
                            }
                          }, 
                          color: contextRed, 
                          buttonText: 'Batal'
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