class ProfileData {
  final String username;
  final String phoneNumber;
    final String address;

  final String electricityConsumerNumber;
  final String waterConsumerNumber;
  final int numberOfPeopleInHouse;
  final String waterBoard;
  final String electricityBoard;
  final Map<String, int> appliances; // Map to hold appliances and their counts

  ProfileData({
    required this.username,
    required this.address,
    required this.phoneNumber,
    required this.electricityConsumerNumber,
    required this.waterConsumerNumber,
    required this.numberOfPeopleInHouse,
    required this.waterBoard,
    required this.electricityBoard,
    required this.appliances, // Include appliances here
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    // Extract appliances from JSON (assuming it's in the format {"applianceName": count})
    Map<String, dynamic> appliancesJson = json['appliances'] ?? {};
    Map<String, int> parsedAppliances = appliancesJson.map((key, value) => MapEntry(key, value as int));

    return ProfileData(
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      electricityConsumerNumber: json['electricityConsumerNumber'],
      waterConsumerNumber: json['waterConsumerNumber'],
      numberOfPeopleInHouse: json['numberOfPeopleInHouse'],
      waterBoard: json['waterBoard'],
      electricityBoard: json['electricityBoard'],
      appliances: parsedAppliances,
    );
  }
}
// /html/body/div/table[1]/tbody/tr[4]/td[20]