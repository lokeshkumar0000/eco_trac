import 'dart:io';

import 'package:electricity/models/profileDataModel.dart';
import 'package:electricity/services/general%20services/helpers.dart';
import 'package:electricity/services/profileDataServices.dart';
import 'package:electricity/view/profile/map_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String textFromSecondScreen = '';

  late ProfileData _profileData;
  final ProfileService _profileService = ProfileService();
  bool editProfile = false;
  bool isLoading = true;
  List<String> selectedAppliances = []; // To store selected appliances
  Map<String, int> applianceCounts = {}; // To store appliance counts
  late String _imagePath; // Variable to store the image path
  late ImageProvider<Object>
      _imageProvider; // Variable to store the image provider

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
    _imagePath = 'https://via.placeholder.com/100'; // Placeholder image path
    _imageProvider = const NetworkImage(
        'https://via.placeholder.com/100'); // Placeholder image
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
          SharedPref().setProfileImage(pickedFile.toString());

    if (pickedFile != null) {
      setState(() {
        _imageProvider = FileImage(File(pickedFile.path));
      });
    }
  }

  Future<void> _fetchProfileData() async {
    try {
      final profileData = await _profileService.fetchProfileData(useApi: false);

      setState(() {
        _profileData = profileData;
        isLoading = false; // Data fetched, loading complete
      });
    } catch (e) {
      // Handle error fetching data
      print('Error fetching data: $e');
      setState(() {
        isLoading = false; // Error occurred, loading complete
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                editProfile = !editProfile;
              });
              print("state changing $editProfile");
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Implement logout functionality
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Show loading indicator
            )
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 20),
                Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSegmentTitle('Contact Information'),
                      _buildProfileTile('Username', _profileData.username),
                      _buildProfileTile(
                          'Phone Number', _profileData.phoneNumber),
                      _buildProfileTile('Address', _profileData.address),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSegmentTitle('Utility Information'),
                      _buildProfileTile('Consumer Number (Electricity)',
                          _profileData.electricityConsumerNumber),
                      _buildProfileTile('Consumer Number (Water)',
                          _profileData.waterConsumerNumber),
                      _buildProfileTile('Choose Electricity Board',
                          _profileData.electricityBoard),
                      _buildProfileTile(
                          'Choose Water Board', _profileData.waterBoard),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSegmentTitle('Household Details'),
                      _buildProfileTile('Number of People in the House',
                          '${_profileData.numberOfPeopleInHouse}'),
                      _buildProfileTile(
                          'Number of Appliances Used', '${_profileData}'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CircleAvatar(radius: 50, backgroundImage: _imageProvider),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      _getImage();
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sanjeev',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '1234567890',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentTitle(String segmentTitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        segmentTitle,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProfileTile(String title, String subtitle) {
    if (title == 'Number of Appliances Used') {
      List<String> displayAppliances = _profileData.appliances.entries
          .where((entry) => entry.value > 0)
          .map((entry) => '${entry.key} (${entry.value})')
          .toList();

      return ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Wrap(
          children: [
            for (String appliance in displayAppliances)
              (editProfile)
                  ? Chip(
                      label: Text(appliance),
                      onDeleted: () {
                        setState(() {
                          String key = appliance.split('(').first.trim();
                          _profileData.appliances[key] = 0;
                        });
                      },
                    )
                  : Chip(
                      label: Text(appliance),
                    ),
            if (editProfile)
              ElevatedButton(
                onPressed: () {
                  _showApplianceDialog();
                },
                child: Text('Edit Appliances'),
              ),
          ],
        ),
      );
    } else if (title == 'Choose Electricity Board' ||
        title == 'Choose Water Board') {
      return ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: editProfile
            ? DropdownButtonFormField<String>(
                value: subtitle,
                items: _getDropdownItems(title),
                onChanged: (newValue) {
                  setState(() {
                    subtitle = newValue!;
                  });
                },
              )
            : Text(subtitle),
        onTap: () {
          if (editProfile) return;
          // Handle onTap (editable fields)
          print('$title tapped');
        },
      );
    } else if (title == 'Address') {
      return ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: editProfile?Icon(Icons.search):SizedBox(),
        onTap: () {
          if (editProfile) {
            FocusScope.of(context).requestFocus(new FocusNode());
            goToSecondScreen(context);
          }
          
          // Handle onTap (editable fields)
          print('$title tapped');
        },
      );
    } else {
      return ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: editProfile
            ? TextFormField(
                initialValue: subtitle,
                keyboardType: title == "Number of People in the House"
                    ? TextInputType.number
                    : TextInputType.text,
              )
            : Text(subtitle),
        onTap: () {
          if (editProfile) return;
          // Handle onTap (editable fields)
          print('$title tapped');
        },
      );
    }
  }

  void goToSecondScreen(BuildContext context) async {
    String dataFromSecondPage = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StreetMap(),
        ));
    setState(() {
      textFromSecondScreen = dataFromSecondPage;
    });
  }

  List<DropdownMenuItem<String>> _getDropdownItems(String title) {
    List<String> items = [];

    if (title == 'Choose Electricity Board') {
      items = ['TNEB', 'EB1', 'EB2']; // Example electricity board options
    } else if (title == 'Choose Water Board') {
      items = [
        'TWAD',
        'Water Board A',
        'Water Board B'
      ]; // Example water board options
    }

    return items.map((item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      );
    }).toList();
  }

  Future<void> _showApplianceDialog() async {
    Map<String, int> applianceCountsTemp = {}; // Temporarily store counts

    List<String> appliances = [
      'TV',
      'Refrigerator',
      'Microwave',
      'Washing Machine',
      'AC',
      // Add more appliances as needed
    ];

    appliances.forEach((appliance) {
      applianceCountsTemp[appliance] = applianceCounts[appliance] ?? 0;
    });

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Select Appliances'),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    for (String appliance in appliances)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(appliance),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (applianceCountsTemp[appliance]! > 0) {
                                        applianceCountsTemp[appliance] =
                                            applianceCountsTemp[appliance]! - 1;
                                      }
                                    });
                                  },
                                ),
                                Text(applianceCountsTemp[appliance].toString()),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      applianceCountsTemp[appliance] =
                                          applianceCountsTemp[appliance]! + 1;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      applianceCounts.clear();
                      applianceCounts
                          .addAll(applianceCountsTemp); // Update the counts
                      selectedAppliances = applianceCounts.keys
                          .toList(); // Update selected appliances
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
