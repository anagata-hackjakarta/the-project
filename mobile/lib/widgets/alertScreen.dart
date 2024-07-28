import 'package:flutter/material.dart';
import 'package:safina/config/them.dart';
import 'package:intl/intl.dart';
import 'package:safina/widgets/CardNotif.dart';
import 'package:safina/widgets/cardIncident.dart';
import 'package:safina/widgets/cardRobot.dart';

import '../widgets/cardSummary.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});

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
              height: MediaQuery.of(context).size.height * 0.05,
              color: Colors.black,
            ),
            Container(
              color: Colors.red,
              // height: 95% of screen and width full
              height: MediaQuery.of(context).size.height * 0.86,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.speed_rounded, color: Colors.white, size: 100),
                  SizedBox(height: 16,),
                  Text(
                    'WATCHOUT!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text(
                    'You were driving at 80 km/h in a 50 km/h zone. \n Please slow down and adhere to the speed limit.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
