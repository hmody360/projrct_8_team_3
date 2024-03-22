class MedicationModel {
  final String medicationId;
  final DateTime createdAt;
  final String medicationName;
  final int pills;
  final int days;
  final String userId;
  final String before;
  final bool isCompleted;
  final String time;

  MedicationModel({
    required this.medicationId,
    required this.createdAt,
    required this.medicationName,
    required this.pills,
    required this.days,
    required this.userId,
    required this.before,
    required this.isCompleted,
    required this.time,
  });

  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    return MedicationModel(
      medicationId: json['medicationId'],
      createdAt: DateTime.parse(json['created_at']),
      medicationName: json['medicationName'] ?? "",
      pills: json['pills'] ?? 0,
      days: json['days'] ?? 0,
      userId: json['userId'],
      before: json['before'] ?? '',
      time: json['time'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicationId': medicationId,
      'created_at': createdAt.toIso8601String(),
      'medicationName': medicationName,
      'pills': pills,
      'days': days,
      'userId': userId,
      'before': before,
      'isCompleted': isCompleted,
      'time': time,
    };
  }
}
