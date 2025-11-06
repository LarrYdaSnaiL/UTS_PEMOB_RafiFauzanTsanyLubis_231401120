import 'package:flutter/material.dart';
import '../models/quiz_models.dart';

class DummyData {
  static final List<QuizCategory> categories = [
    QuizCategory(
      id: 'html',
      name: 'HTML',
      iconPath: 'assets/icons/html.svg',
      color: Colors.orange.shade100,
      questions: [
        Question(
          id: 'q1',
          text: 'Who is making the Web standards?',
          options: [
            'The World Wide Web Consortium',
            'Microsoft',
            'Mozilla',
            'Google',
          ],
          correctAnswer: 'The World Wide Web Consortium',
        ),
        Question(
          id: 'q2',
          text: 'What does HTML stand for?',
          options: [
            'Hyper Text Markup Language',
            'Home Tool Markup Language',
            'Hyperlinks and Text Markup Language',
            'Hyper Tool Multi Language',
          ],
          correctAnswer: 'Hyper Text Markup Language',
        ),
        Question(
          id: 'q3',
          text: 'Choose the correct HTML element for the largest heading:',
          options: ['<heading>', '<h1>', '<h6>', '<head>'],
          correctAnswer: '<h1>',
        ),
      ],
    ),
    QuizCategory(
      id: 'js',
      name: 'JAVASCRIPT',
      iconPath: 'assets/icons/js.svg',
      color: Colors.yellow.shade100,
      questions: [
        Question(
          id: 'q1',
          text: 'Inside which HTML element do we put the JavaScript?',
          options: ['<scripting>', '<js>', '<javascript>', '<script>'],
          correctAnswer: '<script>',
        ),
        Question(
          id: 'q2',
          text: 'How do you write "Hello World" in an alert box?',
          options: [
            'alert("Hello World");',
            'msg("Hello World");',
            'alertBox("Hello World");',
            'msgBox("Hello World");',
          ],
          correctAnswer: 'alert("Hello World");',
        ),
      ],
    ),
    QuizCategory(
      id: 'react',
      name: 'REACT',
      iconPath: 'assets/icons/react.svg',
      color: Colors.blue.shade100,
      questions: [
        Question(
          id: 'q1',
          text: 'What is React?',
          options: [
            'A JavaScript library for building user interfaces',
            'A server-side framework',
            'A database',
            'An operating system',
          ],
          correctAnswer: 'A JavaScript library for building user interfaces',
        ),
      ],
    ),
    QuizCategory(
      id: 'cpp',
      name: 'C++',
      iconPath: 'assets/icons/cpp.svg',
      color: Colors.blue.shade300,
      questions: [
        Question(
          id: 'q1',
          text:
              'Which of the following is a correct syntax to output "Hello World" in C++?',
          options: [
            'cout << "Hello World";',
            'print("Hello World");',
            'System.out.println("Hello World");',
            'console.log("Hello World");',
          ],
          correctAnswer: 'cout << "Hello World";',
        ),
      ],
    ),
    QuizCategory(
      id: 'python',
      name: 'PYTHON',
      iconPath: 'assets/icons/python.svg',
      color: Colors.blue.shade200,
      questions: [
        Question(
          id: 'q1',
          text: 'What is the correct syntax to output "Hello World" in Python?',
          options: [
            'print("Hello World")',
            'p("Hello World")',
            'echo "Hello World"',
            'cout << "Hello World"',
          ],
          correctAnswer: 'print("Hello World")',
        ),
      ],
    ),
  ];

  static QuizCategory getCategoryById(String id) {
    return categories.firstWhere((category) => category.id == id);
  }
}
