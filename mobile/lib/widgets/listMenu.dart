import 'package:flutter/material.dart';

import 'menuIcon.dart';


class Item {
  final String title;
  final Image icon;

  Item({required this.title, required this.icon});
}

class ListMenu extends StatelessWidget {
  const ListMenu({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Item> items = [
      Item(
          title: 'Earning',
          icon: Image.asset(
            'assets/images/ic_generic.png',
            width: 50,
          )),
      Item(
          title: 'History',
          icon: Image.asset(
            'assets/images/ic_history.png',
            width: 50,
          )),
      Item(
          title: 'MyDrive',
          icon: Image.asset(
            'assets/images/ic_analyze.png',
            width: 50,
          )),
      Item(
          title: 'Training',
          icon: Image.asset(
            'assets/images/ic_graduation.png',
            width: 50,
          )),
      // Add more items as needed
    ];

    return Container(
      width: double.infinity,
      height: 100,
      // color: Colors.red,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Number of columns
          childAspectRatio: 1, // Aspect ratio for the icons
        ),
        itemCount: items.length, // Total number of icons
        itemBuilder: (context, index) {
          return Menuicon(
            title: items[index].title,
            icon: items[index].icon,
          );
        },
      ),
    );
  }
}
