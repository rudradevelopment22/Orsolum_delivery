class DeliveryTask {
  final String taskId;
  final String pickup;
  final String drop;
  final String status;

  DeliveryTask({
    required this.taskId,
    required this.pickup,
    required this.drop,
    required this.status,
  });

  factory DeliveryTask.fromJson(Map<String, dynamic> json) {
    return DeliveryTask(
      taskId: json['taskId'] ?? '',
      pickup: json['pickup'] ?? '',
      drop: json['drop'] ?? '',
      status: json['status'] ?? 'pending',
    );
  }
}
