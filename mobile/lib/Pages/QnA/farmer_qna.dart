import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/Pages/QnA/new_question.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class QnAPage extends StatefulWidget {
  const QnAPage({Key? key}) : super(key: key);

  @override
  State<QnAPage> createState() => _QnAState();
}

enum QuestionFilter { All, Answered, NotAnswered }

const authorId = "11001100";
bool _isLoading = false;
bool filterByAnswered = false; // Initially, show all questions

class _QnAState extends State<QnAPage> {
  List<Map<String, String>> allQuestions = [];
  List<Map<String, String>> myQuestions = [];

  final TextEditingController _searchController = TextEditingController();
  PageController _pageController = PageController(initialPage: 0);
  int selectedTabIndex = 0;
  final List<String> tabLabels = ["All Questions", "My Questions"];
  QuestionFilter selectedFilter = QuestionFilter.All;

  @override
  void initState() {
    super.initState();
    // Fetch questions from Firebase Firestore
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final firestore = FirebaseFirestore.instance;

    try {
      setState(() {
        _isLoading = true; // Show the loading indicator
      });

      // Fetch all questions from Firebase collection
      final allQuestionsQuery =
          await firestore.collection("questions_and_answers").get();
      allQuestions = allQuestionsQuery.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final questionData = {
          'docID': doc.id,
          'question': data['questionTopic'] as String,
          'questionDescription': data['questionDescription'] as String,
          'imagePath': data['image'] as String,
          'answer': data['answer'] as String,
          'authorID': data['author'] as String,
        };
        print("Fetched question: $questionData");
        return questionData;
      }).toList();

      // Filter my questions where authorID is "13113132131"
      myQuestions = allQuestions
          .where((question) => question['authorID'] == authorId)
          .toList();

      // Show a toast message
      Fluttertoast.showToast(
        msg: 'දත්ත සාර්ථකව ලබා ගන්නා ලදී',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER, // Show at the top
        backgroundColor: Colors.green, // Background color
        textColor: Colors.white, // Text color
      );
    } catch (e) {
      // Handle any errors
      print("Error fetching questions: $e");
      Fluttertoast.showToast(
        msg:
            "ප්‍රශ්න ලබා ගැනීමේ දෝෂයකි. කරුණාකර ඔබගේ අන්තර්ජාල සම්බන්ධතාවය පරීක්ෂා කරන්න.  $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      setState(() => _isLoading = false // Hide the loading indicator
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ප්‍රශ්න සහ පිළිතුරු"),
        backgroundColor: Color.fromARGB(255, 1, 130, 65),
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
                    buttonBorderColour: const Color.fromARGB(255, 42, 175, 46),
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
                  icon: const Icon(Icons.filter_list,
                      color: Colors.black, size: 30.0),
                  onPressed: () {
                    // Call the filter dialog function
                    _showFilterDialog(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.refresh,
                      color: Colors.black, size: 30.0),
                  onPressed: () {
                    // Call your data refresh method here
                    fetchQuestions();
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
                  setState(() {
                    selectedTabIndex = 0;
                  });
                  _pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    selectedTabIndex == 0
                        ? const Color(0xFFFFC700)
                        : Colors.green,
                  ),
                  foregroundColor: MaterialStateProperty.all(
                    selectedTabIndex == 0 ? Colors.black : Colors.white,
                  ),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(
                      color:
                          selectedTabIndex == 0 ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: selectedTabIndex == 0
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ),
                child: const Text("සියලු ප්‍රශ්න"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedTabIndex = 1;
                  });
                  _pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    selectedTabIndex == 1
                        ? const Color(0xFFFFC700)
                        : Colors.green,
                  ),
                  foregroundColor: MaterialStateProperty.all(
                    selectedTabIndex == 1 ? Colors.black : Colors.white,
                  ),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(
                      color:
                          selectedTabIndex == 1 ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: selectedTabIndex == 1
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ),
                child: const Text("මගේ ප්‍රශ්න"),
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
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 30.0), // Adjust the margin as needed
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddQuestion(); // Use the imported CustomDialog widget
              },
            );
          },
          backgroundColor: Colors.green,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30.0,
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionsList(List<Map<String, String>> questions) {
    List<Map<String, String>> filteredQuestions = [];

    switch (selectedFilter) {
      case QuestionFilter.All:
        filteredQuestions = questions;
        break;
      case QuestionFilter.Answered:
        filteredQuestions = questions
            .where((question) => (question['answer'] ?? '').isNotEmpty)
            .toList();
        break;
      case QuestionFilter.NotAnswered:
        filteredQuestions = questions
            .where((question) => (question['answer'] ?? '').isEmpty)
            .toList();
        break;
    }

    return ListView.builder(
      itemCount: filteredQuestions.length,
      itemBuilder: (context, index) {
        final question = filteredQuestions[index];
        final hasAnswer =
            question['answer'] == null || question['answer']!.isEmpty;

        return Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color.fromARGB(255, 42, 175, 46),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      question['question']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 8.0),
                      child: Text(
                        question['questionDescription'] ??
                            '', // Use questionDescription here
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 15.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          question['imagePath']!,
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
                        color: hasAnswer ? Colors.red : Colors.green,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(8.0),
                      child: Text(
                        hasAnswer ? "තවම පිළිතුරක් නැත" : question['answer']!,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  if (question['authorID'] == authorId)
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.black, size: 32),
                            onPressed: () {
                              _showEditDialog(context, question);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red, size: 32),
                            onPressed: () {
                              _showDeleteConfirmation(context, question);
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
                    hasAnswer ? Icons.error : Icons.check_circle,
                    color: hasAnswer ? Colors.red : Colors.green,
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

  void _showEditDialog(BuildContext context, Map<String, dynamic> question) {
    final TextEditingController questionController = TextEditingController();
    questionController.text = question['question'];
    final TextEditingController descriptionController = TextEditingController();
    descriptionController.text = question['questionDescription'];

    showDialog(
      context: context,
      builder: (context) {
        double dialogWidth =
            MediaQuery.of(context).size.width * 0.9; // Adjust the desired width

        return SizedBox(
          width: dialogWidth,
          child: AlertDialog(
            title: const Text(
              'ප්‍රශ්නය සංස්කරණය කරන්න',
              style: TextStyle(color: Colors.black),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: questionController,
                      decoration: InputDecoration(
                        labelText: 'ප්‍රශ්නය',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: descriptionController,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'විස්තරය',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final firestore = FirebaseFirestore.instance;
                          await firestore
                              .collection('questions_and_answers')
                              .doc(question['docID'])
                              .update({
                            'question': questionController.text,
                            'questionDescription': descriptionController.text,
                          });

                          Navigator.pop(context);
                          await fetchQuestions();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // Background color
                          onPrimary: Colors.white, // Text color
                        ),
                        child: const Text('යාවත්කාලීන කරන්න'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // Background color
                          onPrimary: Colors.white, // Text color
                        ),
                        child: const Text('අවලංගු කරන්න'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, Map<String, dynamic> question) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              const Text('ප්‍රශ්නය මකන්න', style: TextStyle(color: Colors.red)),
          content: const Text('ඔබට මෙම ප්‍රශ්නය මැකීමට අවශ්‍ය බව විශ්වාසද?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'අවලංගු කරන්න',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Delete the question from Firestore
                final firestore = FirebaseFirestore.instance;
                await firestore
                    .collection('questions_and_answers')
                    .doc(question['docID'])
                    .delete();

                // Close the dialog
                Navigator.pop(context);

                // Fetch updated data
                await fetchQuestions();
              },
              child: const Text('මකන්න'),
            ),
          ],
        );
      },
    );
  }

  // Function to show the filter dialog
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ප්‍රශ්න පෙරහන් කරන්න'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('සියලු ප්‍රශ්න'),
                leading: Radio(
                  value: QuestionFilter.All,
                  groupValue: selectedFilter,
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: const Text('පිළිතුරු දුන් ප්‍රශ්න'),
                leading: Radio(
                  value: QuestionFilter.Answered,
                  groupValue: selectedFilter,
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: const Text('පිළිතුරු නැති ප්‍රශ්න'),
                leading: Radio(
                  value: QuestionFilter.NotAnswered,
                  groupValue: selectedFilter,
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value!;
                    });
                    Navigator.pop(context);
                  },
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
    const MaterialApp(
      home: QnAPage(),
    ),
  );
}
