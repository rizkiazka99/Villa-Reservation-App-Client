import 'package:get/get.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/reviews/villa_reviews_response.dart';

class VillaReviewsScreenController extends GetxController {
  Repository repository = Repository();
  
  RxBool _reviewsLoading = false.obs;
  RxBool _isFetched = false.obs;
  RxString _id = ''.obs;
  RxString _name = ''.obs;
  RxString _selectedOrder = 'Tinggi ke Rendah'.obs;
  Rxn<VillaReviewsResponse> _villaReviewsData = Rxn<VillaReviewsResponse>();

  bool get reviewsLoading => _reviewsLoading.value;
  bool get isFetched => _isFetched.value;
  String get id => _id.value;
  String get name => _name.value;
  String get selectedOrder => _selectedOrder.value;
  VillaReviewsResponse? get villaReviewsData => _villaReviewsData.value;

  set reviewsLoading(bool reviewsLoading) =>
      this._reviewsLoading.value = reviewsLoading;
  set isFetched(bool isFetched) =>
      this._isFetched.value = isFetched;
  set id(String id) => this._id.value = id;
  set name(String name) => this._name.value = name;
  set selectedOrder(String selectedOrder) =>
      this._selectedOrder.value = selectedOrder;
  set villaReviewsData(VillaReviewsResponse? villaReviewsData) =>
      this._villaReviewsData.value = villaReviewsData;

  List<String> orders = ['Tinggi ke Rendah', 'Rendah ke Tinggi'];

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments['id'].toString();
    name = Get.arguments['name'];
    getVillaReviewsDesc();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<VillaReviewsResponse?> getVillaReviewsDesc() async {
    print(id);
    reviewsLoading = true;
    isFetched = false;
    VillaReviewsResponse? res = await repository.getVillaReviewsDesc(id);
    villaReviewsData = res;
    isFetched = true;
    reviewsLoading = false;

    return villaReviewsData;
  }

  Future<VillaReviewsResponse?> getVillaReviewsAsc() async {
    print(id);
    reviewsLoading = true;
    isFetched = false;
    VillaReviewsResponse? res = await repository.getVillaReviewsAsc(id);
    villaReviewsData = res;
    isFetched = true;
    reviewsLoading = false;

    return villaReviewsData;
  }
}