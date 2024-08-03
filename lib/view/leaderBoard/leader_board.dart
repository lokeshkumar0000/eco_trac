import 'package:electricity/services/general%20services/helpers.dart';
import 'package:flutter/material.dart';
import 'dart:math';

const Color cool = Color(0xFF181A2F);
Color probtn = Color(0xFF0C3329);
Color leadbtn = Color(0xFF196F3D);
Color gold = Color(0xFFD0B13E);
Color silver = Color(0xFFE7E7E7);
Color bronze = Color(0xFFA45735);

class LeaderBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
final Random random = Random();

  List<String> names = [];
  List<String> litems = [];
  List<String> kwhConsumed = [];
  List<String> scores = [];

  @override
  void initState() {
    super.initState();
    generateLists();
    insertCurrentUser();
  }

  void generateLists() {
    names = List.generate(32, (index) => "User${index + random.nextInt(101)}");
    litems = List.generate(32, (index) => "${index + 1}");

    int prevValue = 10; // Start from 10 or any base number you prefer
    kwhConsumed = List.generate(32, (index) {
      int nextValue = prevValue + random.nextInt(1000); // Generate a random increment
      prevValue = nextValue;
      return "$nextValue KWH";
    });

    scores = List.generate(32, (index) => "${index * 100}");
  }

void insertCurrentUser() {
  // Assuming the current user's details
  String currentUser = "Current User";
  String currentUserKwh = "1800 KWH"; // Current user's kWh consumption

  // Finding the index to insert the current user based on their kWh consumption
  int insertIndex = kwhConsumed.indexWhere((kwh) => currentUserKwh.compareTo(kwh) <= 0);

  if (insertIndex == -1) {
    // If the current user's consumption is greater than all in the list, add to the end
    insertIndex = names.length;
  }

  setState(() {
    names.insert(insertIndex, currentUser);
    litems.insert(insertIndex, "${insertIndex+1}");
    kwhConsumed.insert(insertIndex, currentUserKwh);
    scores.insert(insertIndex, "Current Score");

    // Update indices of upcoming items
    for (int i = insertIndex + 1; i < names.length; i++) {
      litems[i] = "${i + 1}";
    }
  });
}
  @override
  Widget build(BuildContext context) {
        int randomNumber = random.nextInt(101);

    return Scaffold(
      // bottomNavigationBar: BottomAppBar(
      //   child: Container(
      //     color: cool,
      //     child: Card(
      //       margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      //       elevation: 0,
      //       color: Colors.blue,
      //       child: Container(
      //         padding: EdgeInsets.all(8.0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             Text("Pos",
      //                 style: TextStyle(
      //                     color: Colors.black, fontWeight: FontWeight.bold)),
      //             Text(
      //               "Name",
      //               style: TextStyle(
      //                   color: Colors.black, fontWeight: FontWeight.bold),
      //             ),
      //             Text(
      //               "KWH Consumed",
      //               style: TextStyle(
      //                   color: Colors.black, fontWeight: FontWeight.bold),
      //             ),
      //             Text(
      //               "Score",
      //               style: TextStyle(
      //                   color: Colors.black, fontWeight: FontWeight.bold),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: ColorConstants.white,
                )),
            automaticallyImplyLeading: false,
            backgroundColor: probtn,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 200.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(4.0),
              child: Container(
                // color: avtar_backGround1,
                height: 50,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // SizedBox(width: 35),
                      Text("Position",
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontWeight: FontWeight.bold)),
                      // SizedBox(width: 60),
                      Text(
                        "Name",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold),
                      ),
                      // SizedBox(width: 60),
                      Text(
                        "KWH Consumed",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold),
                      ),
                      // SizedBox(width: 60),
                      Text(
                        "Score",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[leadbtn.withOpacity(0.5), cool])),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                        "LEADERBOARD",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Hero(
                      tag: "reward",
                      child: Image.asset(
                        "assets/rewards.png".toString(),
                        height: 70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            elevation: 9.0,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => buildList(context, index),
              childCount: litems.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildList(BuildContext txt, int index) {
    int ind = index + 1;
    final pos = litems[index];
    final name = names[index];
    final kwh = kwhConsumed[index];
    final score = scores.reversed.toList()[index];

    Widget listItem;

    if (ind == 1) {
      listItem = buildListItem(pos, name, kwh, score, gold);
    } else if (ind == 2) {
      listItem = buildListItem(pos, name, kwh, score, silver);
    } else if (ind == 3) {
      listItem = buildListItem(pos, name, kwh, score, bronze);
    } else {
      listItem = buildListItem(pos, name, kwh, score, Colors.white);
    }

    return Stack(
      children: [
        Container(
          color: Colors.grey[200],
          child: listItem,
        ),
      ],
    );
  }

  Widget buildListItem(
      String pos, String name, String kwh, String score, Color bgColor) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      shadowColor: Colors.grey[200],
      color: bgColor,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              pos,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              name,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              kwh,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              score,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
