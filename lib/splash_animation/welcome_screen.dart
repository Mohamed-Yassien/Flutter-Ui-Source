import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Image.network(
            'https://media.tenor.com/pzNKI_Hif0MAAAAd/martin-lawrence.gif',
            fit: BoxFit.fitHeight,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Start',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
