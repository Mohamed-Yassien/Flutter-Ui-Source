import 'package:flutter/material.dart';

class StackTutorial extends StatelessWidget {
  const StackTutorial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Stack Tutorial',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 200,
            color: Colors.teal,
          ),
          Positioned(
            bottom: -30,
            left: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                  color: Colors.tealAccent,
                  gradient: RadialGradient(colors: [
                    Colors.red,
                    Colors.yellow,
                    Colors.purple,
                  ]),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 5,
                      blurRadius: 2,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
