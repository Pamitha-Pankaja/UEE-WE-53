import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/Pages/QnA/filter_qna.dart';
import 'package:mobile/Pages/QnA/new_question.dart';
import 'package:photo_view/photo_view.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AnswerPage extends StatefulWidget {
  const AnswerPage({Key? key}) : super(key: key);

  @override
  State<AnswerPage> createState() => _QnAState();
}

enum QuestionFilter { All, Answered, NotAnswered }

bool _isLoading = false;
bool filterByAnswered = false; // Initially, show all questions

class _QnAState extends State<AnswerPage> {
  List<Map<String, String>> allQuestions = [];

  final TextEditingController _searchController = TextEditingController();
  PageController _pageController = PageController(initialPage: 0);
  int selectedTabIndex = 0;
  final List<String> tabLabels = ["All Questions"];
  TextEditingController _answerController = TextEditingController();
  Map<String, bool> isEditingMap =
      {}; // Map to track edit mode for each question
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
        };
        // Initialize edit mode for each question to false
        isEditingMap[questionData['docID']!] = false;
        print("Fetched question: $questionData");
        return questionData;
      }).toList();

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
      setState(() => _isLoading = false); // Hide the loading indicator
    }
  }

  Future<void> updateAnswer(String docID, String newAnswer) async {
    final firestore = FirebaseFirestore.instance;

    try {
      // Update the answer in the Firestore collection
      await firestore
          .collection("questions_and_answers")
          .doc(docID)
          .update({'answer': newAnswer});

      // Show a toast message
      Fluttertoast.showToast(
        msg: 'පිළිතුර සාර්ථකව යාවත්කාලීන කරන ලදී',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Fetch questions from Firebase Firestore
      fetchQuestions();
    } catch (e) {
      // Handle any errors
      print("Error updating answer: $e");
      Fluttertoast.showToast(
        msg: "පිළිතුර යාවත්කාලීන කිරීමේ දෝෂයකි. $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<void> deleteQuestion(String docID) async {
    final firestore = FirebaseFirestore.instance;

    try {
      // Delete the question from the Firestore collection
      await firestore.collection("questions_and_answers").doc(docID).delete();

      // Show a toast message
      Fluttertoast.showToast(
        msg: 'ප්‍රශ්නය සාර්ථකව මකා ඇත',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      fetchQuestions();
    } catch (e) {
      // Handle any errors
      print("Error deleting question: $e");
      Fluttertoast.showToast(
        msg: "ප්‍රශ්නය මැකීමේ දෝෂයකි. $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Q&A"),
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
                  icon: const Icon(
                    Icons.filter_list,
                    color: Colors.black, // Change icon color to black
                    size: 30.0, // Increase icon size slightly
                  ),
                  onPressed: () {
                    // Handle filter button press here
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
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _buildQuestionsList(allQuestions),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 20.0), // Adjust the margin as needed
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
                      padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 8.0),
                      child: Text(
                        question['questionDescription'] ??
                            '', // Use questionDescription here
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Show the image with zoom when clicked
                      _showImageZoom(context, question['imagePath']!);
                    },
                    child: Align(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isEditingMap[question['docID']] == true
                            ? Expanded(
                                child: EditableText(
                                  controller: _answerController,
                                  cursorColor: Colors.blue,
                                  onChanged: (text) {
                                    // Handle changes to the answer in edit mode
                                  },
                                  style: TextStyle(
                                      color: Colors.black), // Add style
                                  focusNode: FocusNode(), // Add focusNode
                                  cursorOpacityAnimates:
                                      true, // You can set this to true or false as needed
                                  backgroundCursorColor: Colors.blue,
                                ),
                              )
                            : Text(
                                hasAnswer
                                    ? "තවම පිළිතුරක් නැත"
                                    : question['answer']!,
                                style: const TextStyle(color: Colors.black),
                              ),
                        IconButton(
                          icon: isEditingMap[question['docID']] == true
                              ? Icon(Icons.send, color: Colors.blue)
                              : Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            setState(() {
                              if (isEditingMap[question['docID']] == true) {
                                // Save the edited answer and exit edit mode
                                updateAnswer(
                                    question['docID']!, _answerController.text);
                                isEditingMap[question['docID']!] = false;
                              } else {
                                // Enter edit mode and populate the answer field
                                _answerController.text =
                                    question['answer'] ?? '';
                                isEditingMap[question['docID']!] = true;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // // Overflow (three-dot) icon
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: PopupMenuButton<int>(
                  //     itemBuilder: (context) => [
                  //       const PopupMenuItem<int>(
                  //         value: 1,
                  //         child: Text("Delete"),
                  //       ),
                  //     ],
                  //     onSelected: (value) {
                  //       if (value == 1) {
                  //         // Delete the question
                  //         deleteQuestion(question['docID']!);
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              ),
              // Align the overflow (three-dot) icon with the check circle icon
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        hasAnswer ? Icons.error : Icons.check_circle,
                        color: hasAnswer ? Colors.red : Colors.green,
                        size: 32,
                      ),
                    ],
                  ),
                  PopupMenuButton<int>(
                    itemBuilder: (context) => [
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text("Delete"),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 1) {
                        // Delete the question
                        deleteQuestion(question['docID']!);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showImageZoom(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: PhotoView(
                imageProvider: NetworkImage(imagePath),
                backgroundDecoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
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
      home: AnswerPage(),
    ),
  );
}
