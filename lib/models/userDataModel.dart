class UserData {
  final String electricConsumerNo;
  final String fullName;
  final String phoneNo;
  final String waterConsumerNo;
  final bool status;

  UserData({
    required this.electricConsumerNo,
    required this.fullName,
    required this.phoneNo,
    required this.waterConsumerNo,
    required this.status,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      electricConsumerNo: json['electric_consumer_no'],
      fullName: json['fullname'],
      phoneNo: json['phone_no'],
      waterConsumerNo: json['water_consumer_no'],
      status: json['status'],
    );
  }
}
