import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class QnA extends StatefulWidget {
  const QnA({Key? key}) : super(key: key);

  @override
  State<QnA> createState() => _QnAState();
}

class _QnAState extends State<QnA> {
  List<Map<String, String>> allQuestions = [
    {
      'question': 'Question 1',
      'imagePath': 'assets/qna/qna1.jpg',
      'answer': 'meka thama answer eka'
    },
    {'question': 'Question 2', 'imagePath': 'assets/qna/qna2.jpeg'},
    {'question': 'Question 3', 'imagePath': 'assets/qna/qna3.jpg'},
  ];

  List<Map<String, String>> myQuestions = [
    {'question': 'Question 1', 'imagePath': 'assets/qna/qna4.jpg'},
    {'question': 'Question 2', 'imagePath': 'assets/qna/qna1.jpg'},
    {'question': 'Question 3', 'imagePath': 'assets/qna/qna2.jpeg'},
  ];

  final TextEditingController _searchController = TextEditingController();

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Q&A"),
        backgroundColor: const Color.fromARGB(255, 42, 175, 46),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: SearchBarAnimation(
                    enableButtonBorder: true,
                    buttonBorderColour: Color.fromARGB(255, 42, 175, 46),
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
                  icon: const Icon(
                    Icons.filter_list,
                    color: Colors.black, // Change icon color to black
                    size: 30.0, // Increase icon size slightly
                  ),
                  onPressed: () {
                    // Handle filter button press here
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  _pageController.animateToPage(0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFFFC700)),
                ),
                child: const Text(
                  "All Questions",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _pageController.animateToPage(1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: const Text(
                  "My Questions",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _buildQuestionsList(allQuestions),
                _buildQuestionsList(myQuestions),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement the logic to add questions here
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }

  Widget _buildQuestionsList(List<Map<String, String>> questions) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        final hasAnswer = question['answer'] != null;

        return Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: const Color.fromARGB(255, 42, 175, 46),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.fromLTRB(
              8.0, 10.0, 8.0, 0.0), // Left, Top, Right, and Bottom margins
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(question['question']!),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 15.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          question['imagePath']!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: const Color.fromARGB(255, 42, 175, 46),
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(8.0),
                      child: Text(
                        'Answer to ${question['answer']}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit,
                              color: Colors.black, size: 32), // Increased size
                          onPressed: () {
                            // Add edit functionality here
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: Colors.red, size: 32), // Increased size
                          onPressed: () {
                            // Add delete functionality here
                          },
                        ), 
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    hasAnswer ? Icons.check_circle : Icons.error,
                    color: hasAnswer ? Colors.green : Colors.red,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: QnA(),
    ),
  );
}