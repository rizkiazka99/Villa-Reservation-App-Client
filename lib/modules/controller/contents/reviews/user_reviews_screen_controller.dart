import 'package:get/get.dart';
import 'package:reservilla/data/api/repository.dart';
import 'package:reservilla/data/models/contents/reviews/user_reviews_response.dart';

class UserReviewsScreenController extends GetxController {
  Repository repository = Repository();

  RxBool _userReviewsLoading = false.obs;
  RxBool _isFetched = false.obs;
  Rxn<UserReviewsResponse> _userReviewsData = Rxn<UserReviewsResponse>();

  bool get userReviewsLoading => _userReviewsLoading.value;
  bool get isFetched => _isFetched.value;
  UserReviewsResponse? get userReviewsData => _userReviewsData.value;

  set userReviewsLoading(bool userReviewsLoading) =>
      this._userReviewsLoading.value = userReviewsLoading;
  set isFetched(bool isFetched) =>
      this._isFetched.value = isFetched;
  set userReviewsData(UserReviewsResponse? userReviewsData) =>
      this._userReviewsData.value = userReviewsData;

  @override
  void onInit() {
    super.onInit();
    getUserReviews();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<UserReviewsResponse?> getUserReviews() async {
    isFetched = false;
    userReviewsLoading = true;
    UserReviewsResponse? res = await repository.getUserReviews();
    userReviewsData = res;
    userReviewsLoading = false;
    isFetched = true;

    return userReviewsData;
  }
}