import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/reviews/add_review_response.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/default_snackbar.dart';
import 'package:reservilla/widgets/loader_dialog.dart';

class AddReviewController extends GetxController {
  Repository repository = Repository();

  TextEditingController commentController = TextEditingController();
  final commentFormKey = GlobalKey<FormState>();
  var autoValidateComment = AutovalidateMode.disabled;

  RxInt _villaId = 0.obs;
  RxString _villaName = ''.obs;
  RxBool _addReviewLoading = false.obs;
  RxDouble _rating = 0.0.obs;
  Rxn<AddReviewResponse> _addReviewData = Rxn<AddReviewResponse>();

  int get villaId => _villaId.value;
  String get villaName => _villaName.value;
  bool get addReviewLoading => _addReviewLoading.value;
  double get rating => _rating.value;
  AddReviewResponse? get addReviewData => _addReviewData.value;

  set villaId(int villaId) =>
      this._villaId.value = villaId;
  set villaName(String villaName) =>
      this._villaName.value = villaName;
  set addReviewLoading(bool addReviewLoading) =>
      this._addReviewLoading.value = addReviewLoading;
  set rating(double rating) =>
      this._rating.value = rating;
  set addReviewData(AddReviewResponse? addReviewData) =>
      this._addReviewData.value = addReviewData;

  @override
  void onInit() {
    super.onInit();
    villaId = Get.arguments['VillaId'];
    villaName = Get.arguments['villa_name'];
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }

  Future<AddReviewResponse?> addReview() async {
    dynamic data = {
      'VillaId': villaId,
      'rating': rating,
      'comment': commentController.text
    };

    addReviewLoading = true;
    AddReviewResponse? res = await repository.addReview(data);
    addReviewData = res;
    addReviewLoading = false;

    return addReviewData;
  }

  initiateAddReview() async {
    loaderDialog(
      const SpinKitRing(color: contextOrange),
      'Mohon tunggu...'
    );

    await addReview();

    if (addReviewData!.status) {
      Get.back();
      Get.offAllNamed(dashboardScreenRoute);
      defaultSnackbar('Sukses!', 'Terima kasih untuk ulasan Anda!');
    } else {
      if (addReviewData!.message == "You have reviewed this Villa already!") {
        Get.back();
        defaultSnackbar('Ups!', 'Anda sudah mengulas Villa ini sebelumnya');
      }
    }
  }
}