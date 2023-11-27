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
      title: 'What is 2 + 2?',
      options: {'5': false, '30': false, '4': true, '10': false},
    ),
    Question(
      id: '11',
      title: 'What is 10 + 20?',
      options: {'5': false, '30': true, '4': false, '10': false},
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
