import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/villas/villas_response.dart';

class HomeScreenController extends GetxController {
  Repository repository = Repository();

  ScrollController scrollController = ScrollController();

  final RxBool _villasLoading = false.obs;
  final RxBool _isFetched = false.obs;
  final Rxn<VillasResponse> _villasData = Rxn<VillasResponse>();
  final RxList<Datum> _villas = <Datum>[].obs;

  bool get villasLoading => _villasLoading.value;
  bool get isFetched => _isFetched.value;
  VillasResponse? get villasData => _villasData.value;
  List<Datum> get villas => _villas;

  set villasLoading(bool villasLoading) => _villasLoading.value = villasLoading;
  set isFetched(bool isFetched) => _isFetched.value = isFetched;
  set villasData(VillasResponse? villasData) => _villasData.value = villasData;
  set villas(List<Datum> villas) => _villas.value = villas;

  @override
  void onInit() {
    super.onInit();
    getVillas();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  getRecommendedVillas() {
    if (villasData!.data.isNotEmpty) {
      villas = villasData!.data.where((villa) => 
        villa.averageRating != null && villa.averageRating > 4
      ).toList();
    } else {
      villas = [];
    }
  }

  Future<VillasResponse?> getVillas() async {
    isFetched = false;
    villasLoading = true;

    VillasResponse? result = await repository.getVillas();
    villasData = result;
    getRecommendedVillas();

    villasLoading = false;
    isFetched = true;

    return villasData;
  }
}
