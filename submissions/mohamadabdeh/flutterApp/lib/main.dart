import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// root app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COM206 Project',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WelcomePage(),
    );
  }
}

///  XXXXXXXXXXXXX welcome page
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar('Welcome Page'),
      body: _centerContent(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phone_android, size: 90, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'COM206 Flutter Project',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text('Student Name: Mohamad Abdeh', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text('Student ID: XXXXXXXX', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text(
              'COM206\nVISUAL PROGRAMMING',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            _button('Start App', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HomePage()));
            }),
          ],
        ),
      ),
    );
  }
}

/// XXXXXXXXXXXXX home page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar('Home Page'),
      body: _centerContent(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Flutter!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              'This application demonstrates page navigation and user input handling in Flutter.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _button('Go to Menu Page', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SecondPage()));
            }),
          ],
        ),
      ),
    );
  }
}

/// XXXXXXXXXXXXX menu page 
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  final List<Map<String, String>> items = const [
    {'title': 'Full Name', 'label': 'Enter your full name', 'result': 'Copied full name will appear here'},
    {'title': 'Age', 'label': 'Enter your age', 'result': 'Copied age will appear here'},
    {'title': 'Department', 'label': 'Enter your department', 'result': 'Copied department will appear here'},
    {'title': 'University', 'label': 'Enter your university name', 'result': 'Copied university name will appear here'},
    {'title': 'City', 'label': 'Enter your city', 'result': 'Copied city will appear here'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar('Menu Page'),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.folder_open, color: Colors.blueGrey),
              title: Text(item['title']!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ThirdPage(
                      pageTitle: item['title']!,
                      inputLabel: item['label']!,
                      resultPlaceholder: item['result']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// XXXXXXXXXXXXX input page
class ThirdPage extends StatefulWidget {
  final String pageTitle, inputLabel, resultPlaceholder;

  const ThirdPage({
    super.key,
    required this.pageTitle,
    required this.inputLabel,
    required this.resultPlaceholder,
  });

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final controller = TextEditingController();
  String text = '';

  void copyText() {
    setState(() => text = controller.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Text copied successfully')),
    );
  }

  void clearText() {
    setState(() {
      controller.clear();
      text = '';
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(widget.pageTitle),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: widget.inputLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            /// result box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                text.isEmpty ? widget.resultPlaceholder : text,
                style: const TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(height: 20),
            _button('Copy Text', copyText),
            const SizedBox(height: 10),
            _button('Clear Text', clearText),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _button('Go to Welcome Page', () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const WelcomePage()),
                    (route) => false,
                  );
                }),
                _button('Back', () => Navigator.pop(context)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// XXXXXXXXXXXXX reusable widgets 

AppBar _appBar(String title) =>
    AppBar(title: Text(title), centerTitle: true);

Widget _button(String text, VoidCallback onPressed) =>
    ElevatedButton(onPressed: onPressed, child: Text(text));

Widget _centerContent(Widget child) => Center(
      child: Padding(padding: const EdgeInsets.all(20), child: child),
    );