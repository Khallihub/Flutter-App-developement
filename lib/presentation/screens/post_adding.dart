import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget textSection = const Padding(
      padding: EdgeInsets.all(25),
      child: TextField(
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Description",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
      ),
    );

    return MaterialApp(
      title: 'Post',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(220, 81, 226, 254),
          title: const Text('Post'),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 7.0),
            const TextButton(
              onPressed: null,
              child: TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Title",
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: null,
                    child: Text(
                      'Upload Image',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 0, 200, 255),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            textSection,
            const Center(
              child: ElevatedButton(
                onPressed: null,
                child: Text(
                  'Post',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 26, 197, 249),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
