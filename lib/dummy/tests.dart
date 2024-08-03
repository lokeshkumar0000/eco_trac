import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

const Color avtar_backGround = Color(0xFF2FCB72);
const Color avtar_backGround1 = Color(0xFF0C3329);
const Color cool = Color(0xFF181A2F);
Color probtn = Color(0xFF0C3329);
Color leadbtn = Color(0xFF196F3D);
Color gold = Color(0xFFD0B13E);
Color silver = Color(0xFFE7E7E7);
Color bronze = Color(0xFFA45735);

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<String> names = List.generate(32, (index) => "User ${index + 1}");
  List<String> litems = List.generate(32, (index) => "${index + 1}");

  List<String> kwhConsumed = List.generate(32, (index) => "${index + 10} KWH");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: cool,
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              elevation: 0,
              color: Colors.blue,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Pos",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                      foregroundColor: Colors.green,
                    ),
                    Text(
                      "Name",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "KWH Consumed",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: probtn,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 200.0,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(4.0),
                child: Container(
                  color: avtar_backGround1,
                  height: 50,
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(width: 35),
                        Text(
                          "Position",
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 52),
                        Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 60),
                        Text(
                          "KWH Consumed",
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontWeight: FontWeight.bold),
                        ),
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
                      SizedBox(
                        height: 20,
                      ),
                      Icon(
                        Icons.emoji_events_rounded,
                        color: gold,
                        size: 70,
                      ),
                    ],
                  ),
                ),
              ),
              elevation: 9.0,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) =>
                    buildList(context, index),
                childCount: litems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(BuildContext txt, int index) {
    int ind = index + 1;
    final pos = litems[index];
    final name = names[index];
    final kwh = kwhConsumed[index];

    Widget listItem;

    if (ind == 1) {
      listItem = Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        shadowColor: Colors.grey[200],
        color: gold,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                pos,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                foregroundColor: Colors.green,
              ),
              Text(
                name,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                kwh,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    } else if (ind == 2) {
      listItem = Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        shadowColor: Colors.grey[200],
        color: silver,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                pos,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                foregroundColor: Colors.green,
              ),
              Text(
                name,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                kwh,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    } else if (ind == 3) {
      listItem = Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        shadowColor: Colors.grey[200],
        color: bronze,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                pos,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                foregroundColor: Colors.green,
              ),
              Text(
                name,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                kwh,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    } else {
      listItem = Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        shadowColor: Colors.grey[200],
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                pos,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                foregroundColor: Colors.green,
              ),
              Text(
                name,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                kwh,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
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
}
