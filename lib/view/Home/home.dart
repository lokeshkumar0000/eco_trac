import 'package:carousel_slider/carousel_slider.dart';
import 'package:electricity/view/Reward/rewards_page.dart';
import 'package:electricity/view/leaderBoard/leader_board.dart';
import 'package:electricity/view/login/LoginPage.dart';
import 'package:electricity/view/profile/Profile_Page.dart';
import 'package:electricity/view/usagePages/electricityUsage.dart';
import 'package:electricity/view/usagePages/history.dart';
import 'package:electricity/view/usagePages/water_usage.dart';
import 'package:electricity/widgets/charts.dart';
import 'package:electricity/models/usageDataModel.dart';
import 'package:electricity/services/UsageDataServices.dart';
import 'package:electricity/services/general%20services/helpers.dart';
import 'package:electricity/widgets/flip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  final String userName;

  HomePage({Key? key, required this.userName}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UsageData> usageDataList = [];
  Map DashboardData = {
    "image0": {"img": "assets/eco-house.png", "name": "Electricity"},
    "image1": {"img": "assets/water-tap.png", "name": "Water"},
    "image2": {"img": "assets/graph.png", "name": "Graph"},
    "image3": {"img": "assets/gift-box.png", "name": "Rewards"},
    "image4": {"img": "assets/rewards.png", "name": "Leaderboard"},
    "image5": {"img": "assets/referral.png", "name": "Referrals"}
  };

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TableView()));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WaterConsumptionTableView()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Charts()));
        break;

      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RewardsView()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LeaderBoard()));
        break;
      case 5:
        print("No Navigation");

      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => Charts()));
      //   break;
      // Add more cases as needed
      default:
        print("null");
        // Handle other cases or do nothing
        break;
    }
  }

  final con = GestureFlipCardController();
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Use a post-frame callback to wait for the widget to build
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Jump to the last index after the widget builds
      // _controller.jumpToPage(usageDataList.length - 1);
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    UsageDataService usageDataService = UsageDataService();
    usageDataList = await usageDataService.fetchUsageData(useApi: false);
    setState(() {
      _current = usageDataList.length - 1; // Set current index to last index
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: AppBar(
        backgroundColor: ColorConstants.white,
        title: Text(
          "Hi ${widget.userName}!",
          style: TextStyles.subHeading,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Check your usage compared to previous bills",
                      //   style: TextStyles.normalText,
                      // ),
                    ],
                  ),
                  // Spacer(),
                  // IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
                ],
              ),
              CarouselSlider(
                items: usageDataList.map((usageData) {
                  return Builder(
                    builder: (BuildContext context) {
                      return flipCard(
                        cong: con,
                        usageData: usageData,
                      );
                    },
                  );
                }).toList(),
                carouselController: _controller,
                options: CarouselOptions(
                  initialPage: _current,
                  autoPlay: false,
                  reverse: true,
                  animateToClosest: true,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: usageDataList.asMap().entries.map((entry) {
                  return GestureDetector(
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == entry.key
                            ? Colors.teal
                            : Colors.teal.withOpacity(0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Card(
                child: Container(
                    height: size.height * 0.3,
                    color: Colors.white38,
                    child: GridView.count(
                      crossAxisCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                        6,
                        (index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            child: GestureDetector(
                              onTap: () {
                                _navigateToPage(context, index);
                              },
                              child: Container(
                                color: ColorConstants.teal,
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Hero(
                                        tag: "reward",
                                        child: Image.asset(
                                          DashboardData["image${index}"]["img"]
                                              .toString(),
                                          height: 60,
                                        ),
                                      ),
                                      Text(
                                        DashboardData["image${index}"]["name"]
                                            .toString(),
                                        style: TextStyles.normalTextWhite,
                                      )
                                    ]),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildElectricityData(UsageData usageData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Electricity Usage'),
        const SizedBox(height: 8),
        Text('CN no: ${usageData.electricityConsumerNumber}'),
        Text('\$${usageData.electricityAmountPaid}'),
        Text('Kilowatt Used: ${usageData.electricityKilowattUsed} kWh'),
      ],
    );
  }

  Widget _buildWaterData(UsageData usageData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Water Usage'),
        SizedBox(height: 8),
        Text('Date: ${usageData.dateOfBillIssued}'),
        Text('Consumer: ${usageData.waterConsumerNumber}'),
        Text('Amount Paid: \$${usageData.waterAmountPaid}'),
        Text('Liters Used: ${usageData.waterLitersUsed} liters'),
      ],
    );
  }
}
