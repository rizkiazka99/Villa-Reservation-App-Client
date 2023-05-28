import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/profile/edit_profile_response.dart';
import 'package:reservilla/modules/controller/miscellaneous/dashboard_screen_controller.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/default_snackbar.dart';
import 'package:reservilla/widgets/loader_dialog.dart';
import 'package:dio/dio.dart' as dio;
import 'package:reservilla/widgets/upload_dialog.dart';

class EditProfileScreenController extends GetxController {
  Repository repository = Repository();
  DashboardScreenController dashboardScreenController = Get.find<DashboardScreenController>();
  ImagePicker imagePicker = ImagePicker();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  
  final emailFormKey = GlobalKey<FormState>();
  final nameFormKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();

  var autoValidateEmail = AutovalidateMode.disabled;
  var autoValidateName = AutovalidateMode.disabled;
  var autoValidatePhone = AutovalidateMode.disabled;

  File? _image;
  File? get image => this._image;
  set image(File? image) => this._image = image;
  
  RxString _id = ''.obs;
  RxBool _editProfileLoading = false.obs;
  RxString _picturePath = ''.obs;
  RxString _picture = ''.obs;
  RxBool _uploadLoading = false.obs;
  RxInt _uploadProgressReceived = 0.obs;
  RxInt _uploadProgressTotal = 1.obs;
  Rxn<EditProfileResponse> _editProfileData = Rxn<EditProfileResponse>();

  String get id => _id.value;
  bool get editProfileLoading => _editProfileLoading.value;
  String get picturePath => _picturePath.value;
  String get picture => _picture.value;
  bool get uploadLoading => _uploadLoading.value;
  int get uploadProgressReceived => _uploadProgressReceived.value;
  int get uploadProgressTotal => _uploadProgressTotal.value;
  EditProfileResponse? get editProfileData => _editProfileData.value;

  set id(String id) => this._id.value = id;
  set editProfileLoading(bool editProfileLoading) =>
      this._editProfileLoading.value = editProfileLoading;
  set picturePath(String picturePath) =>
      this._picturePath.value = picturePath;
  set picture(String picture) =>
      this._picture.value = picture;
  set uploadLoading(bool uploadLoading) =>
      this._uploadLoading.value = uploadLoading;
  set uploadProgressReceived(int uploadProgressReceived) =>
      this._uploadProgressReceived.value = uploadProgressReceived;
  set uploadProgressTotal(int uploadProgressTotal) =>
      this._uploadProgressTotal.value = uploadProgressTotal;
  set editProfileData(EditProfileResponse? editProfileData) =>
      this._editProfileData.value = editProfileData;
  
  @override
  void onInit() {
    super.onInit();
    if (dashboardScreenController.user != null) {
      id = dashboardScreenController.user!.data.id.toString();
      emailController.text = dashboardScreenController.user!.data.email;
      nameController.text = dashboardScreenController.user!.data.name;
      phoneController.text = '0${dashboardScreenController.user!.data.phone}';
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future getImageByCamera() async {
    var picture = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50
    );

    if (picture?.path != null) {
      picturePath = picture!.path;
      image = File(picture.path);
    }
  }

  Future getImageFromGallery() async {
    var picture = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25
    );

    if(picture?.path != null) {
      picturePath = picture!.path;
      image = File(picture.path);
    }
  }

  void onSendProgress(int received, int total) {
    uploadProgressReceived = received;
    uploadProgressTotal = total;
  }

  Future uploadFile() async {
    uploadLoading = true;
    dio.FormData formData = dio.FormData.fromMap({
      'file': await dio.MultipartFile.fromFile(
        picturePath,
        filename: picture.split('/').last
      ),
      'type': 'profile-picture'
    });
    dynamic res = repository.uploadFile(formData, onSendProgress);
    if (res['error']) {
      picture = res['data']['url'];
      uploadProgressReceived = 0;
      uploadProgressTotal = 1;
    }
    uploadLoading = false;
    
    return res;
  }

  Future<EditProfileResponse?> editProfile() async {
    dynamic dataWithoutPicture = {
      'email': emailController.text,
      'name': nameController.text,
      'phone': phoneController.text
    };

    dynamic dataWithPicture = {
      'email': emailController.text,
      'name': nameController.text,
      'phone': phoneController.text,
      'profile_picture': _picture.value
    };

    EditProfileResponse? res;

    editProfileLoading = true;
    if (_picture.value.isEmpty) {
      res = await repository.editProfile(id, dataWithoutPicture);
    } else {
      res = await repository.editProfile(id, dataWithPicture);
    }
    editProfileData = res;
    editProfileLoading = false;

    return editProfileData;
  }

  initiateEditProfile() async {
    final isEmailValid = emailFormKey.currentState!.validate();
    final isNameValid = nameFormKey.currentState!.validate();
    final isPhoneValid = phoneFormKey.currentState!.validate();

    if (isEmailValid && isNameValid && isPhoneValid) {
      if (_picturePath.value.isNotEmpty) {
        Get.dialog(Obx(() => UploadDialog(
          title: 'Mengunggah Foto Profil', 
          received: _uploadProgressReceived.value, 
          total: _uploadProgressTotal.value
        )));
        dynamic uploadResponse = await uploadFile();

        if (uploadResponse['error']) {
          Get.until((route) => !Get.isDialogOpen!);
          defaultSnackbar('Ups!', 'Terjadi kesalahan saat proses pengunggahan foto profil');
        } else {
          loaderDialog(
            const SpinKitRing(color: contextOrange), 
            'Mohon tunggu...'
          );
          await editProfile();
        }
      } else {
        loaderDialog(
          const SpinKitRing(color: contextOrange), 
          'Mohon tunggu...'
        );
        await editProfile();
      }
      
      if (editProfileData!.status) {
        Get.back();
        Get.offAllNamed(dashboardScreenRoute);
        defaultSnackbar('Sukses!', 'Profil Anda telah diperbarui');
      } else {
        Get.back();
        defaultSnackbar('Ups!', 'Terjadi kesalahan, profil Anda gagal diperbarui');
      }
    } else if (!isEmailValid) {
      autoValidateEmail = AutovalidateMode.always;
    } else if (!isNameValid) {
      autoValidateName = AutovalidateMode.always;
    } else if (!isPhoneValid) {
      autoValidatePhone = AutovalidateMode.always;
    } else {
      autoValidateEmail = AutovalidateMode.always;
      autoValidateName = AutovalidateMode.always;
      autoValidatePhone = AutovalidateMode.always;
    }
  }
}