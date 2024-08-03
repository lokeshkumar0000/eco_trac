import 'package:electricity/models/usageDataModel.dart';
import 'package:electricity/services/general%20services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class flipCard extends StatelessWidget {
  flipCard({super.key, required this.cong, required this.usageData});
  UsageData usageData;
  final GestureFlipCardController cong;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // cong.flipcard();
      },
      child: GestureFlipCard(
        enableController: true,
        controller: cong,
        animationDuration: const Duration(milliseconds: 300),
        axis: FlipAxis.horizontal,
        frontWidget: Center(
          child: Card(
            child: Container(
              width: 400,
              height: 200,
              color: Colors.amber,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const NetworkImage(
                            "https://img.freepik.com/free-vector/battery-energy-storage-from-renewable-solar-wind-power-station_335657-3217.jpg?w=826&t=st=1702026663~exp=1702027263~hmac=cb7c4c807315240c3eeb958f0aa2043be0c3209a9d094eccd6761f8f0f918c31"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.dstATop),
                      ),
                    ),
                  ),
                  usageData.electricityConsumerNumber == 0 ||
                          usageData.electricityConsumerNumber == null
                      ? Center(
                          child: TextFormField(
                              decoration:const InputDecoration(
                                  hintText: "Enter Consumer Number",),keyboardType: TextInputType.number,),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    usageData.waterConsumerNumber.toString(),
                                    style: TextStyles.subHeading,
                                  ),
                                ),
                                Spacer(),
                                const Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "TNEB",
                                    style: TextStyles.subHeadingItalic,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: "Date ",
                                        style: TextStyles.subHeading),
                                    TextSpan(
                                      text: usageData.dateOfBillIssued,
                                      style: TextStyles.normalText,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: "Bill Amount ",
                                            style: TextStyles.normalText),
                                        TextSpan(
                                          text:
                                              "₹ ${usageData.electricityAmountPaid.toString()}",
                                          style: TextStyles.subHeading,
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text.rich(
                                    overflow: TextOverflow.ellipsis,
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: "Status ",
                                            style: TextStyles.normalText),
                                        TextSpan(
                                          text: usageData.electricityStatus ==
                                                  true
                                              ? "PAID"
                                              : "PENDING",
                                          style: usageData.electricityStatus ==
                                                  true
                                              ? TextStyles.subHeadingPaid
                                              : TextStyles.subHeadingUnPaid,
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
        backWidget: Card(
          child: Container(
            width: 400,
            height: 200,
            color: ColorConstants.blue,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/water.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.darken),
                    ),
                  ),
                ),
               usageData.electricityConsumerNumber == 0 ||
                          usageData.electricityConsumerNumber == null
                      ? Center(
                          child: TextFormField(
                              decoration:const InputDecoration(
                                  hintText: "Enter Consumer Number",),keyboardType: TextInputType.number,),
                        ): Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            usageData.waterConsumerNumber.toString(),
                            style: TextStyles.subHeading,
                          ),
                        ),
                        Spacer(),
                        const Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "CCMC",
                            style: TextStyles.subHeadingItalic,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                    text: "Date ",
                                    style: TextStyles.subHeading),
                                TextSpan(
                                  text: usageData.dateOfBillIssued,
                                  style: TextStyles.normalText,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                    text: "Bill Amount ",
                                    style: TextStyles.normalTextWhite),
                                TextSpan(
                                  text:
                                      "₹ ${usageData.waterAmountPaid.toString()}",
                                  style: TextStyles.subHeadingWhite,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(
                            overflow: TextOverflow.ellipsis,
                            TextSpan(
                              children: [
                                const TextSpan(
                                    text: "Status ",
                                    style: TextStyles.normalTextWhite),
                                TextSpan(
                                  text: usageData.waterStatus == true
                                      ? "PAID"
                                      : "PENDING",
                                  style: usageData.waterStatus == true
                                      ? TextStyles.subHeadingPaid
                                      : TextStyles.subHeadingUnPaid,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
