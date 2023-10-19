
import 'package:flutter/material.dart';
import 'package:mobile/utils.dart';

class FavouriteCard extends StatefulWidget {
  final String imageUrl;
  final String itemName;
  final String totalHarvest;
  final String pricePerKg;

  FavouriteCard({
    required this.imageUrl,
    required this.itemName,
    required this.totalHarvest,
    required this.pricePerKg,
  });

  @override
  State<FavouriteCard> createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> favoriteItems = [
      {
        'imageUrl': '[Image url]',
        'itemName': 'Carrot',
        'totalHarvest': 'Total Harvest: 200Kg',
        'pricePerKg': 'Price (1Kg): Rs.350/=',
      },
      // Add more favorite items here
    ];

    return ListView.builder(
      itemCount: favoriteItems.length,
      itemBuilder: (context, index) {
        //final item = favoriteItems[index];
        return Positioned(
          // card1HeG (179:625)
          left: 18,
          top: 143,
          child: Container(
            padding: EdgeInsets.fromLTRB(12, 10, 32, 11),
            width: 394,
            height: 158,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Color(0xffffffff),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color(0x3f0d1e00),
                  offset: Offset(0, 4),
                  blurRadius: 2.5,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // harvestofcarrotsjFN (179:629)
                  margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                  width: 170,
                  height: 137,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    // child: Image.network(
                    //  item.imageUrl,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                Container(
                  // autogroupfgic1Ct (QQiTkztZQh9VpgaGbPfgic)
                  margin: EdgeInsets.fromLTRB(0, 6, 0, 2),
                  width: 168,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // carrotKjN (179:626)
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                        child: Text(
                          'Carrot',
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 1.2125,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      Container(
                        // totalharvest200kgRGc (179:627)
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                        child: Text(
                          'Total Harvest :  200Kg',
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.2125,
                            color: Color(0xff797373),
                          ),
                        ),
                      ),
                      Container(
                        // price1kgrs350XaY (179:628)
                        margin: EdgeInsets.fromLTRB(3, 0, 0, 15),
                        child: Text(
                          'Price (1Kg) : Rs.350/=',
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.2125,
                            color: Color(0xff797373),
                          ),
                        ),
                      ),
                      Container(
                        // group19SBi (179:630)
                        margin: EdgeInsets.fromLTRB(35, 0, 19, 0),
                        width: double.infinity,
                        height: 29,
                        decoration: BoxDecoration(
                          color: Color(0xaf018241),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'View',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              height: 1.2125,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
