import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/auth/verify_password_response.dart';
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

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  final nameFormKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();
  final verifyPasswordFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  var autoValidateName = AutovalidateMode.disabled;
  var autoValidatePhone = AutovalidateMode.disabled;
  var autoValidateVerifyPassword = AutovalidateMode.disabled;
  var autoValidatePassword = AutovalidateMode.disabled;

  File? _image;
  File? get image => this._image;
  set image(File? image) => this._image = image;
  
  RxString _id = ''.obs;
  RxBool _editProfileLoading = false.obs;
  RxBool _verifyPasswordLoading = false.obs;
  RxString _picturePath = ''.obs;
  RxString _picture = ''.obs;
  RxBool _uploadLoading = false.obs;
  RxInt _uploadProgressReceived = 0.obs;
  RxInt _uploadProgressTotal = 1.obs;
  RxBool _showPasswordForm = false.obs;
  RxBool _isPasswordVerified = false.obs;
  RxBool _isVerifyPasswordVisible = true.obs;
  RxBool _isPasswordVisible = true.obs;
  Rxn<EditProfileResponse> _editProfileData = Rxn<EditProfileResponse>();
  Rxn<VerifyPasswordResponse> _verifyPasswordData = Rxn<VerifyPasswordResponse>();

  String get id => _id.value;
  bool get editProfileLoading => _editProfileLoading.value;
  bool get verifyPasswordLoading => _verifyPasswordLoading.value;
  String get picturePath => _picturePath.value;
  String get picture => _picture.value;
  bool get uploadLoading => _uploadLoading.value;
  int get uploadProgressReceived => _uploadProgressReceived.value;
  int get uploadProgressTotal => _uploadProgressTotal.value;
  bool get showPasswordForm => _showPasswordForm.value;
  bool get isPasswordVerified => _isPasswordVerified.value;
  bool get isVerifyPasswordVisible => _isVerifyPasswordVisible.value;
  bool get isPasswordVisible => _isPasswordVisible.value;
  EditProfileResponse? get editProfileData => _editProfileData.value;
  VerifyPasswordResponse? get verifyPasswordData => _verifyPasswordData.value;

  set id(String id) => this._id.value = id;
  set editProfileLoading(bool editProfileLoading) =>
      this._editProfileLoading.value = editProfileLoading;
  set verifyPasswordLoading(bool verifyPasswordLoading) =>
      this._verifyPasswordLoading.value = verifyPasswordLoading;
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
  set showPasswordForm(bool showPasswordForm) =>
      this._showPasswordForm.value = showPasswordForm;
  set isPasswordVerified(bool isPasswordVerified) =>
      this._isPasswordVerified.value = isPasswordVerified;
  set isVerifyPasswordVisible(bool isVerifyPasswordVisible) => 
      this._isVerifyPasswordVisible.value = isVerifyPasswordVisible;
  set isPasswordVisible(bool isPasswordVisible) => 
      this._isPasswordVisible.value = isPasswordVisible;
  set editProfileData(EditProfileResponse? editProfileData) =>
      this._editProfileData.value = editProfileData;
  set verifyPasswordData(VerifyPasswordResponse? verifyPasswordData) =>
      this._verifyPasswordData.value = verifyPasswordData;
  
  @override
  void onInit() {
    super.onInit();
    if (dashboardScreenController.user != null) {
      id = dashboardScreenController.user!.data.id.toString();
      nameController.text = dashboardScreenController.user!.data.name;
      phoneController.text = '0${dashboardScreenController.user!.data.phone}';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    verifyPasswordController.dispose();
    passwordController.dispose();
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

  Future<EditProfileResponse?> uploadProfilePicture() async {
    uploadLoading = true;
    dio.FormData formData = dio.FormData.fromMap({
      'file': await dio.MultipartFile.fromFile(
        picturePath,
        filename: picture.split('/').last
      ),
      'type': 'profile-picture'
    });
    print(formData.files[0].value.contentType);
    print(formData.files[0].value.filename);
    print(formData.files[0].value.headers);
    print(formData.fields[0].value);
    print(formData.boundary);
    print(formData.camelCaseContentDisposition);
    EditProfileResponse res = await repository.uploadProfilePicture(id, formData, onSendProgress);
    /*if (res['error']) {
      picture = res['data']['url'];
      uploadProgressReceived = 0;
      uploadProgressTotal = 1;
    }*/
    editProfileData = res;
    uploadLoading = false;
    
    return editProfileData;
  }
  
  void showAndHidePassword() {
    isPasswordVisible = !isPasswordVisible;
  }

  void showAndHideVerifyPassword() {
    isVerifyPasswordVisible = !isVerifyPasswordVisible;
  }

  Future<VerifyPasswordResponse?> verifyPassword() async {
    dynamic data = {
      'password': verifyPasswordController.text
    };

    verifyPasswordLoading = true;
    VerifyPasswordResponse? res = await repository.verifyPassword(data);
    verifyPasswordData = res;
    verifyPasswordLoading = false;

    return verifyPasswordData;
  }

  initiateVerifyPassword() async {
    final isVerifyPasswordValid = verifyPasswordFormKey.currentState!.validate();

    if (isVerifyPasswordValid) {
      loaderDialog(
        const SpinKitRing(color: contextOrange), 
        'Mohon tunggu...'
      );
      await verifyPassword();

      if (verifyPasswordData!.status) {
        Get.back();
        isPasswordVerified = true;
        showPasswordForm = true;
        Get.back();
        print(isPasswordVerified);
      } else {
        Get.back();
        defaultSnackbar('Ups', 'Password tidak terverifikasi, tolong periksa kembali password Anda');
        print(isPasswordVerified);
      }
    } else {
      autoValidateVerifyPassword = AutovalidateMode.always;
    }
  }

  Future<EditProfileResponse?> editProfile() async {
    dynamic dataWithoutPassword = {
      'name': nameController.text,
      'phone': phoneController.text
    };

    dynamic dataWithPassword = {
      'name': nameController.text,
      'phone': phoneController.text,
      'password': passwordController.text
    };

    EditProfileResponse? res;

    editProfileLoading = true;
    if (isPasswordVerified) {
      if (showPasswordForm) {
        res = await repository.editProfile(id, dataWithPassword);
      } else {
        res = await repository.editProfile(id, dataWithoutPassword);
      }
    } else {
      res = await repository.editProfile(id, dataWithoutPassword);
    }
    editProfileData = res;
    editProfileLoading = false;

    return editProfileData;
  }

  initiateEditProfile() async {
    final isNameValid = nameFormKey.currentState!.validate();
    final isPhoneValid = phoneFormKey.currentState!.validate();
    

    if (isPasswordVerified && showPasswordForm) {
      final isPasswordValid = passwordFormKey.currentState!.validate();

      if (isNameValid && isPhoneValid && isPasswordValid) {
        if (_picturePath.value.isNotEmpty) {
          Get.dialog(Obx(() => UploadDialog(
            title: 'Mengunggah Foto Profil', 
            received: _uploadProgressReceived.value, 
            total: _uploadProgressTotal.value
          )));
          await uploadProfilePicture();

          if (!editProfileData!.status) {
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
      } else if (!isNameValid) {
        autoValidateName = AutovalidateMode.always;
      } else if (!isPhoneValid) {
        autoValidatePhone = AutovalidateMode.always;
      } else if (!isPasswordValid) {
        autoValidatePassword = AutovalidateMode.always;
      } else {
        autoValidateName = AutovalidateMode.always;
        autoValidatePhone = AutovalidateMode.always;
        autoValidatePassword = AutovalidateMode.always;
      }
    } else {
      if (isNameValid && isPhoneValid) {
        if (_picturePath.value.isNotEmpty) {
          Get.dialog(Obx(() => UploadDialog(
            title: 'Mengunggah Foto Profil', 
            received: _uploadProgressReceived.value, 
            total: _uploadProgressTotal.value
          )));
          await uploadProfilePicture();

          if (!editProfileData!.status) {
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
      } else if (!isNameValid) {
        autoValidateName = AutovalidateMode.always;
      } else if (!isPhoneValid) {
        autoValidatePhone = AutovalidateMode.always;
      } else {
        autoValidateName = AutovalidateMode.always;
        autoValidatePhone = AutovalidateMode.always;
      }
    }
  }
}