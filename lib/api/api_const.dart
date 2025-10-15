abstract class ApiConst {
  /// Default Configuration
  // static const String baseUrl = String.fromEnvironment("base_url");
  // static const String storageBaseUrl = String.fromEnvironment(
  //   "storage_base_url",
  // );
  // static const String googleApiKey = String.fromEnvironment("google_api_key");

  static const String baseUrl = "https://api.orsolum.com/api";
  static const String socketUrl = "https://api.orsolum.com/delivery";
  static const String storageBaseUrl =
      "https://orsolum.s3.ap-south-1.amazonaws.com/";
  static const String googleApiKey = "AIzaSyCUsYoaqevf0B1pSHfDovZZfb20qzNc62A";

  // static CFEnvironment get cashFreeEnviroment =>
  //     AppUtils.isProductionStage
  //         ? CFEnvironment.SANDBOX
  //         : CFEnvironment.SANDBOX;

  static ImageEndpoint? _imageEndpoint;

  static ImageEndpoint get imageEndPoint {
    _imageEndpoint ??= ImageEndpoint.__();
    return _imageEndpoint!;
  }

  /// Delivery api
  /// Auth
  static const String loginOtp = "/deliveryboy/login/otp/v1";
  static const String login = "/deliveryboy/login/v1";
  static const String registerOtp = "/deliveryboy/register/otp/v1";
  static const String register = "/deliveryboy/register/v1";

  static const String userDetail = "/deliveryboy/update/profile/v1";

  /// User
  static const String getUser = "/my/profile/v1";
  static const String updateUser = "/deliveryboy/update/profile/v1";

  /// Home
  static const String newOrders = "/deliveryboy/new/orders/v1";
  static const String acceptOrders = "/deliveryboy/accept/order/v1";
  static const String pickupOrders = "/deliveryboy/pickup/order/v1";

  /// Categories
  static const String categoriesLocal = "/user/get/all/categories/v1";
  static const String categoriesOnlineStore = "/online/store/all/categories/v1";
  static const String subCategories = "/online/store/all/sub/categories/v1";

  /// Stores
  static const String stores = "/user/get/all/stores/v1";

  static String storeDetails({required String id}) =>
      "/user/store/details/$id/v1";

  /// Address
  static const String addAddress = "/create/address/v1";
  static const String editAddress = "/create/edit/address/v1";
  static const String getAddress = "/get/address/v1";
  static const String getUserAddresses = "/get/address/user/list/v1";

  static String getAddressById({required String id}) => "/get/address/$id/v1";

  /// Orders
  static const String orders = "/order/list/v2";

  /// Google
  static String get searchPlaces =>
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";

  /// Subscription
  static const String subscriptionPlan = "/user/membership/details/v1";
  static const String purchaseSubscriptionPlan = "/purchase/premium/v1";
}

class ImageEndpoint {
  ImageEndpoint.__();
}
