import 'package:flutter/material.dart';
import 'package:mobile/Components/Buyer/itemCard.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
//import '../Components/BuyersComponents/itemsCard.dart';
class BuyerHome extends StatefulWidget {
  final Map<String, dynamic> userData;
  const BuyerHome({required this.userData});

  @override
  State<BuyerHome> createState() => _BuyerHomeState();
}

class _BuyerHomeState extends State<BuyerHome> {
  final TextEditingController _searchController = TextEditingController();
  List<String> filteredItems = []; // Initialize the filtered items list

  List<Item> items = [
    Item("ළූණු", "assets/onion.jpeg"),
    Item("තක්කාලි", "assets/tomatoNew.jpg"),
    Item("වට්ටක්කා", "assets/pumpkin.jpg"),
    Item("තිරිඟු", "assets/wheat.jpg"),
    Item("බඩ ඉරිඟු", "assets/corn.png"),
    // Add more items here
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 130, 65),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, bottom: 8.0, right: 10, top: 5),
            child: Row(
              children: [
                Expanded(
                  child: SearchBarAnimation(
                    enableButtonBorder: true,
                    buttonBorderColour: Color.fromARGB(255, 48, 116, 161),
                    textEditingController: _searchController,
                    isOriginalAnimation: false,
                    trailingWidget: const Icon(Icons.search),
                    secondaryButtonWidget: const Icon(
                      Icons.cancel,
                      color: Color.fromARGB(255, 100, 147, 170),
                    ),
                    buttonWidget: const Icon(Icons.search),
                    searchBoxWidth: 300.0,
                    onFieldSubmitted: (String value) {
                      debugPrint('onFieldSubmitted value $value');
                      // You can perform a search or filter the items based on the value entered here.
                    },
                    hintText: "සොයන්න",
                    onChanged: (value) {
                      // You can update the search results as the user types.
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    // Add your cart action here
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: Container(
                height: 120, // Adjust the height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80, // Adjust the width of each item
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //border: Border.all(width: 2, color: Colors.blue),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              items[index].imageUrl,
                              width: 150,
                              height: 150,
                              scale: 1.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height:4), // Adjust the spacing between the image and text
                        Text(
                          items[index].name,
                          style: TextStyle(
                              fontSize: 14.0), // Adjust the text style
                        ),
                      ],
                    );
                  },
                ),
              )),
          Container(
              color: Color.fromARGB(136, 217, 217, 217),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 0.0, bottom: 0.0, left: 20.0, right: 0.0),
                  child: Text(
                    'ආසන්නතම යෝජනා',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
              child: ItemCard(),
            ),
           
        ],
      ),
    );
  }
}

class Item {
  final String name;
  final String imageUrl;

  Item(this.name, this.imageUrl);
}