import 'dart:async';
import 'package:get/get.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/villas/villa_detail_response.dart';
import 'package:reservilla/widgets/default_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class VillaDetailController extends GetxController {
  Repository repository = Repository();

  final RxBool _villaDetailLoading = false.obs;
  final RxString _id = ''.obs;
  final Rxn<VillaDetailResponse> _villaDetailData = Rxn<VillaDetailResponse>();

  bool get villaDetailLoading => _villaDetailLoading.value;
  String get id => _id.value;
  VillaDetailResponse? get villaDetailData => _villaDetailData.value;

  set villaDetailLoading(bool villaDetailLoading) =>
      _villaDetailLoading.value = villaDetailLoading;
  set id(String id) => _id.value = id;
  set villaDetailData(VillaDetailResponse? villaDetailData) =>
      _villaDetailData.value = villaDetailData;

  @override
  void onInit() {
    super.onInit();
    getVillaDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<VillaDetailResponse?> getVillaDetail() async {
    id = Get.arguments['id'];
    villaDetailLoading = true;

    VillaDetailResponse? res = await repository.getVillaDetail(id);
    villaDetailData = res;

    villaDetailLoading = false;

    return villaDetailData;
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
