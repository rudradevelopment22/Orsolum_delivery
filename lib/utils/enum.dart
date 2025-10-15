enum ApiStatus {
  loading,
  empty,
  error,
  success,
  none,
}

enum Role {
  user,
  retailer,
}

enum OrderStatus {
  pending,
  accepted,
  rejected,
  productShipped,
  onTheWay,
  yourDestination,
  delivered,
  cancelled,
}

enum ReturnStatus {
  pending,
  approved,
  rejected,
  pickedUp,
  success,
  cancelled,
}

enum MessageType{
  image,
  gif,
  video,
  text,
  upload,
}