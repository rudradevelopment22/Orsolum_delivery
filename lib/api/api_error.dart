class ApiError {
  final String title;
  final String message;

  ApiError({this.title = "", this.message = ""});

  factory ApiError.unauthorized() => ApiError(
        title: "Unauthorized",
        message:
            "Sorry, it seems you don't have permission for this action. Please log in again or contact support if you need assistance.",
      );

  factory ApiError.alert({required String message}) => ApiError(
    title: "Alert",
    message: message,
  );

  factory ApiError.noInternet() => ApiError(
      title :"No internet",
      message : "Oops! It looks like you're offline. Please check your internet connection."
  );

  factory ApiError.formatError() => ApiError(
      title :"Oops",
      message : "Invalid format received. Please try again later or contact support if the issue persists."
  );

  factory ApiError.parsingError() => ApiError(
      title :"Oops",
      message : "We couldn't process the information received. Please try again later."
  );

  factory ApiError.connectionError() => ApiError(
      title: "Connection timeout",
      message:
          "Oops, we're having trouble connecting to our servers. Please check your network connection and try again.");

  factory ApiError.serverError() => ApiError(
        title: "Server Error",
        message:
            "Something went wrong on our end. We're working to fix it. Please try again later.",
      );

  factory ApiError.notFound() => ApiError(
        title: "Not Found",
        message:
            "Sorry, we couldn't find what you were looking for. It may no longer be available or the address might be incorrect.",
      );

  factory ApiError.unknown({String? title,String? message}) => ApiError(
        title: title ?? "Something went wrong",
        message: message ??
            "Unexpected error occurred. We're not sure what happened, but we're looking into it. Please try again later.",
      );

  factory ApiError.couponApply({String? title,String? message}) => ApiError(
    title: title ?? "Coupon Error",
    message: message ??
        "The coupon code you entered is invalid, expired, or not applicable to the items in your cart. Please check the code and try again, or contact support for further assistance.",
  );

  factory ApiError.subscriptionExpired({String? title,String? message}) => ApiError(
    title: title ?? "Subscription Expired",
    message: message ??
        "Your current subscription plan is expired. Please renew your plan.",
  );

  factory ApiError.accountNotExist({String? title,String? message}) => ApiError(
    title: title ?? "Account Not Exist",
    message: message ??
        "Your account is not exist with this please try again another number",
  );

  factory ApiError.invalidAadhaarNumber({String? title,String? message}) => ApiError(
    title: title ?? "Invalid aadhaar number",
    message: message ??
        "You enter invalid aadhaar number please enter valid aadhaar number",
  );

  factory ApiError.invalidResponse({String? title,String? message}) => ApiError(
    title: title ?? "Invalid Response Detected",
    message: message ??
        "Something went wrong. Please try again or contact support if the issue persists.",
  );
}
