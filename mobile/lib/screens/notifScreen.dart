import 'package:flutter/material.dart';
import 'package:safina/config/them.dart';
import 'package:intl/intl.dart';
import 'package:safina/widgets/CardNotif.dart';
import 'package:safina/widgets/cardIncident.dart';
import 'package:safina/widgets/cardRobot.dart';

import '../widgets/cardSummary.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = [];
    DateTime startDate = DateTime(2024, 7, 21);
    DateTime endDate = DateTime(2024, 7, 31);
    for (DateTime date = startDate;
        date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
        date = date.add(Duration(days: 1))) {
      dates.add(date);
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              height: 50,
              color: Colors.black,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              decoration: BoxDecoration(
                color: ThemeConfig.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Notification",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: ThemeConfig.primaryColor,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "All",
                        style: TextStyle(fontWeight: FontWeight.w600, color: ThemeConfig.primaryColor),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Unread",
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  children: [
                    // container like card with left border have color red with width 3, and righ side have border radius 20
                    CardNotif(),
                    CardNotif(),
                    CardNotif(),
                    CardNotif(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
