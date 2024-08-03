//  CarouselSlider(
//               items: usageDataList.map((usageData) {
//                 return Builder(
//                   builder: (BuildContext context) {
//                     return Container(
//                       width: MediaQuery.of(context).size.width,
//                       margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 20.0, horizontal: 15.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Text(
//                               'Month: ${usageData.dateOfBillIssued}',
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.teal,
//                               ),
//                             ),
//                             const SizedBox(height: 15),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Expanded(
//                                   child: _buildElectricityData(usageData),
//                                 ),
//                                 Expanded(
//                                   child: _buildWaterData(usageData),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }).toList(),
//               carouselController: _controller,
//               options: CarouselOptions(
//                 initialPage: _current,
//                 autoPlay: false,
//                 enableInfiniteScroll: false,
//                 enlargeCenterPage: true,
//                 aspectRatio: 1.7,
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     _current = index;
//                   });
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: usageDataList.asMap().entries.map((entry) {
//                 return GestureDetector(
//                   child: Container(
//                     width: 8.0,
//                     height: 8.0,
//                     margin: const EdgeInsets.symmetric(
//                         vertical: 8.0, horizontal: 4.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: _current == entry.key
//                           ? Colors.teal
//                           : Colors.teal.withOpacity(0.4),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),