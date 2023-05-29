import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/favorites/add_to_favorite_response.dart';
import 'package:reservilla/data/models/contents/favorites/remove_from_favorite_response.dart';
import 'package:reservilla/data/models/contents/villas/villa_detail_response.dart';
import 'package:reservilla/data/models/miscellaneous/user_response.dart';
import 'package:reservilla/widgets/default_snackbar.dart';
import 'package:reservilla/widgets/loader_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class VillaDetailController extends GetxController {
  Repository repository = Repository();

  RxBool _villaDetailLoading = false.obs;
  RxBool _userLoading = false.obs;
  RxBool _addToFavoriteLoading = false.obs;
  RxString _id = ''.obs;
  Rxn<VillaDetailResponse> _villaDetailData = Rxn<VillaDetailResponse>();
  Rxn<UserResponse> _userData = Rxn<UserResponse>();
  Rxn<AddToFavoriteResponse> _addToFavoriteData = Rxn<AddToFavoriteResponse>();
  RxBool _removeFromFavoriteLoading = false.obs;
  Rxn<RemoveFromFavoriteResponse> _removeFromFavoriteData = Rxn<RemoveFromFavoriteResponse>();

  bool get villaDetailLoading => _villaDetailLoading.value;
  bool get userLoading => _userLoading.value;
  bool get addToFavoriteLoading => _addToFavoriteLoading.value;
  String get id => _id.value;
  VillaDetailResponse? get villaDetailData => _villaDetailData.value;
  UserResponse? get userData => _userData.value;
  AddToFavoriteResponse? get addToFavoriteData => _addToFavoriteData.value;
  bool get removeFromFavoriteLoading => _removeFromFavoriteLoading.value;
  RemoveFromFavoriteResponse? get removeFromFavoriteData => _removeFromFavoriteData.value;

  set villaDetailLoading(bool villaDetailLoading) =>
      this._villaDetailLoading.value = villaDetailLoading;
  set userLoading(bool userLoading) =>
      this._userLoading.value = userLoading;
  set addToFavoriteLoading(bool addToFavoriteLoading) =>
      this._addToFavoriteLoading.value = addToFavoriteLoading;
  set id(String id) => this._id.value = id;
  set villaDetailData(VillaDetailResponse? villaDetailData) =>
      this._villaDetailData.value = villaDetailData;
  set userData(UserResponse? userData) =>
      this._userData.value = userData;
  set addToFavoriteData(AddToFavoriteResponse? addToFavoriteData) =>
      this._addToFavoriteData.value = addToFavoriteData;
  set removeFromFavoriteLoading(bool removeFromFavoriteLoading) =>
      this._removeFromFavoriteLoading.value = removeFromFavoriteLoading;
  set removeFromFavoriteData(RemoveFromFavoriteResponse? removeFromFavoriteData) =>
      this._removeFromFavoriteData.value = removeFromFavoriteData;

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments['id'];
    getVillaDetail();
    getUserData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<VillaDetailResponse?> getVillaDetail() async {
    villaDetailLoading = true;
    VillaDetailResponse? res = await repository.getVillaDetail(id);
    villaDetailData = res;
    villaDetailLoading = false;

    return villaDetailData;
  }

  Future<UserResponse?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getInt('id').toString();
    print(id);
    userLoading = true;
    UserResponse? res = await repository.getUserById(id);
    userData = res;
    userLoading = false;

    return userData;
  }

  Future<AddToFavoriteResponse?> addToFavorite(villaId) async {
    dynamic data = {
      'VillaId': villaId
    };

    addToFavoriteLoading = true;
    AddToFavoriteResponse? res = await repository.addToFavorite(data);
    addToFavoriteData = res;
    addToFavoriteLoading = false;

    return addToFavoriteData;
  }

  initiateAddToFavorite(villaId, villaName) async {
    loaderDialog(
      const SpinKitRing(color: contextOrange), 
      'Mohon tunggu...'
    );
    await addToFavorite(villaId);
    await getUserData();

    if (addToFavoriteData!.status && userData!.message.isNotEmpty) {
      Get.back();
      defaultSnackbar('Sukses!', 'Berhasil menambahkan $villaName ke favorit');
    } else {
      Get.back();
      defaultSnackbar('Ups!', 'Terjadi kesalahan, mohon coba lagi');
    }
  }

  Future<RemoveFromFavoriteResponse?> removeFromFavorite(id) async {
    removeFromFavoriteLoading = true;
    RemoveFromFavoriteResponse? res = await repository.removeFromFavorite(id);
    removeFromFavoriteData = res;
    removeFromFavoriteLoading = false;

    return removeFromFavoriteData;
  }

  initiateRemoveFromFavorite(id, villaName) async {
    loaderDialog(
      const SpinKitRing(color: contextOrange), 
      'Mohon tunggu...'
    );
    await removeFromFavorite(id);
    await getUserData();

    if (removeFromFavoriteData!.status && userData!.message.isNotEmpty) {
      Get.back();
      defaultSnackbar('Sukses!', 'Berhasil menghilangkan $villaName dari favorit');
    } else {
      Get.back();
      defaultSnackbar('Ups!', 'Terjadi kesalahan, mohon coba lagi');
    }
  }

  launchDialer(String contactNumber) async {
    Uri dialerUri = Uri.parse('tel:+62$contactNumber');

    try {
      await launchUrl(dialerUri);
    } catch (err) {
      return defaultSnackbar('Ups', 'Terjadi kesalahan, silahkan coba lagi');
    }
  }

  launchMaps(String mapsUrl) async {
    Uri mapsUri = Uri.parse(mapsUrl);

    try {
      if (await canLaunchUrl(mapsUri)) {
        await launchMaps(mapsUrl);
      } else {
        await launchUrl(mapsUri);
      }
    } catch (err) {
      return defaultSnackbar('Ups', 'Terjadi kesalahan, silahkan coba lagi');
    }
  }
}
