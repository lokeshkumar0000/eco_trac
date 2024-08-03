import 'package:electricity/services/general%20services/helpers.dart';
import 'package:flutter/material.dart';

class RewardsView extends StatefulWidget {
  RewardsView({Key? key}) : super(key: key);

  @override
  State<RewardsView> createState() => _RewardsViewState();
}

class _RewardsViewState extends State<RewardsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rewards",
        ),
      ),
    );
  }
}
