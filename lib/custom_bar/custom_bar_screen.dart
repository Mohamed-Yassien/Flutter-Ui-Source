import 'package:flutter/material.dart';
import 'package:flutter_ui_source/google_maps/constant/app_constant.dart';

class CustomBarScreen extends StatefulWidget {
  const CustomBarScreen({Key? key}) : super(key: key);

  @override
  State<CustomBarScreen> createState() => _CustomBarScreenState();
}

class _CustomBarScreenState extends State<CustomBarScreen> {
  int currentIndex = 0;

  List<BottomNavigationBarItem> items(curIndex) => List.generate(
        3,
        (index) => BottomNavigationBarItem(
          icon: Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(
              maxHeight: 40,
              maxWidth: 40,
            ),
            margin: const EdgeInsets.all(0),
            // padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: curIndex == index ? AppConstant.linearGradient : null,
              borderRadius:
                  curIndex == index ? BorderRadius.circular(15) : null,
            ),
            child: Icon(
              index == 0
                  ? Icons.add_a_photo_rounded
                  : index == 1
                      ? Icons.account_balance_sharp
                      : Icons.settings,
            ),
          ),
          label: '',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Custom Bar'),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          bottomAppBarTheme: const BottomAppBarTheme(
            elevation: 0,
            color: Colors.blue, // set the color of the bottom navigation bar
          ),
        ),
        child: BottomNavigationBar(
          items: items(currentIndex),
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
         // useLegacyColorScheme: true,
          //enableFeedback: false,
         // backgroundColor: Colors.white,
          //elevation: 8,
          iconSize: 20,
          selectedIconTheme: const IconThemeData(
            size: 16.67,
            color: Colors.white,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 16.67,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
