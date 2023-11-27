import 'package:flutter/material.dart';
import 'package:project_1_husseinmawla_fatimanassrallah/constants.dart';
import 'package:project_1_husseinmawla_fatimanassrallah/models/question_model.dart';
import '../widgets/questions_widgets.dart';
import '../widgets/next_button.dart';
import 'package:project_1_husseinmawla_fatimanassrallah/widgets/result_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Question> _questions = [
    Question(
      id: '10',
      title: ' What does HTML stand for?',
      options: {'Hyper Text Markup Language': true, 'Hyperlinks and Text Markup Language': false, 'Home Tool Markup Language': false, 'Hyper Text Makeup Language': false},
    ),
    Question(
      id: '11',
      title: 'Which of the following is not a fundamental data type in programming?',
      options: {'Integer': false, 'Array': true, ' Boolean': false, 'String': false},
    ),

    Question(
      id: '13',
      title: 'What is the full form of CSS in web development?',
      options: {'Creative Style Sheets': false, 'Cascading Style Sheets': true, 'Computer Style Sheets': false, 'Colorful Style Sheets': false},
    ),
    Question(
      id: '14',
      title: 'What is the purpose of the "if-else" statement in programming?',
      options: {'To loop through code': false, 'To perform arithmetic operations': true, 'To define a class': false, 'To make decisions based on conditions': false},
    ),
    Question(
      id: '15',
      title: 'Which data structure uses Last In, First Out (LIFO) approach?',
      options: {'Queue': false, 'Stack': true, 'Linked List': false, 'Array': false},
    ),
    Question(
      id: '16',
      title: 'Which of the following is a relational database management system (RDBMS)?',
      options: {'MongoDB': false, 'PostgreSQL': true, 'Redis': false, ' Cassandra': false},
    ),
    Question(
      id: '17',
      title: 'What is the purpose of a compiler in programming?',
      options: {'To debug the program': false, 'To convert high-level language to machine code': true, 'To execute the program': false, 'To design the user interface': false},
    ),
    Question(
      id: '18',
      title: 'What does OOP stand for in programming?',
      options: {' Ordinary Operating Procedure': false, 'Object-Oriented Programming': true, 'Open Object Programming': false, 'Overarching Object Protocol': false},
    ), Question(
      id: '19',
      title: 'Which sorting algorithm has the worst-case time complexity of O(n^2)?',
      options: {'Quick Sort': false, ' Merge Sort': true, ' Bubble Sort': false, 'Insertion Sort': false},
    ), Question(
      id: '20',
      title: 'In networking, what does TCP stand for?"?',
      options: {' Transfer Control Protocol': false, 'Transmission Control Protocol': true, 'Transfer Connection Protocol': false, ' Transmission Connection Protocol': false},
    ),



  ];
  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;

  void nextQuestion() {
    if (index == _questions.length - 1) {
      showDialog(
        context: context,
        builder: (ctx) => ResultBox(
          result: score,
          questionLength: _questions.length,

        ),
      );
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please pick an option to continue!'),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(vertical: 20.0),
          ),
        );
      }
    }
  }

  void checkAnswerAndUpdate(bool value, int optionIndex) {
    if (isAlreadySelected) {
      return;
    } else {
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
      if (value == true) {
        score++;
      }
    }
  }

  void resetExam() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: background,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            QuestionWidget(
              indexAction: index,
              totalQuestions: _questions.length,
              question: _questions[index].title,
            ),
            const Divider(color: neutral),
            const SizedBox(
              height: 25.0,
            ),
            for (int i = 0; i < _questions[index].options.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () => checkAnswerAndUpdate(
                    _questions[index].options.values.toList()[i] == true,
                    i,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isPressed
                          ? _questions[index].options.values.toList()[i] == true
                          ? correct
                          : incorrect
                          : neutral,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      _questions[index].options.keys.toList()[i],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: NextButton(
              nextQuestion: nextQuestion,
            ),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton.extended(
            onPressed: resetExam,
            label: const Text('Reset Exam'),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
