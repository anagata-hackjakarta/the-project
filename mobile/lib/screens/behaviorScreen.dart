import 'package:flutter/material.dart';
import 'package:safina/config/them.dart';
import 'package:intl/intl.dart';
import 'package:safina/widgets/cardIncident.dart';
import 'package:safina/widgets/cardRobot.dart';

import '../widgets/cardSummary.dart';

class BehaviorScreen extends StatelessWidget {
  const BehaviorScreen({super.key});

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
                  "MyDrive",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                    Text(
                      'Driving Behavior Analysis',
                      style: TextStyle(
                        color: Color(0xFF16171A),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 60,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFE0E2E7),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Daily',
                                      style: TextStyle(
                                        color: Color(0xFF00B14F),
                                        fontSize: 13,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                'Weekly',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF969AA5),
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          'July',
                          style: TextStyle(
                            color: Color(0xFF16171A),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dates.length,
                        reverse: true,
                        // add space between items
                        itemExtent: 60,
                        itemBuilder: (context, index) {
                          DateTime date = dates[index];
                          return Column(
                            children: [
                              Text(DateFormat('EEE').format(date)),
                              // Day of the week
                              SizedBox(height: 8),
                              // set color green if same date as today
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: date.day == DateTime.now().day
                                      ? Color(0xFF00B14F)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    date.day.toString(),
                                    style: TextStyle(
                                      color: date.day == DateTime.now().day
                                          ? Colors.white
                                          : Color(0xFF16171A),
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Text(
                      'Daily Score',
                      style: TextStyle(
                        color: Color(0xFF16171A),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // screen width / 2
                          width: MediaQuery.of(context).size.width / 2 - 32,
                          child: Column(
                            children: [
                              Text(
                                '75',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF00B14F),
                                  fontSize: 64,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w900,
                                  height: 0.01,
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Your Score',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF969AA5),
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 32,
                          child: Column(
                            children: [
                              Text(
                                '60',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ThemeConfig.secondaryFontColor,
                                  fontSize: 64,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w900,
                                  height: 0.01,
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Average Score',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF969AA5),
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2), child: Cardincident(),),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2), child: Cardincident(),),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2), child: Cardincident(),),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2), child: Cardincident(),),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Summary',
                      style: TextStyle(
                        color: Color(0xFF16171A),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: 16),
                    CardSummary(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
