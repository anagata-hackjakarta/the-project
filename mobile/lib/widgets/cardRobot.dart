import 'package:flutter/material.dart';

class CardRobot extends StatelessWidget {
  const CardRobot({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              new BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 2,
                  spreadRadius: -4,
                  offset: Offset(0, 0)),
            ],
          ),
          child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/ic_robot.png',
                      width: 100,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 196.65,
                          child: Text(
                            'Improve your driving with Grab driving simulation',
                            style: TextStyle(
                              color: Color(0xFF00B14F),
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 196.65,
                          child: Text(
                            'Get a better score, get more benefits',
                            style: TextStyle(
                              color: Color(0xFF626572),
                              fontSize: 11,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        Text(
                          'Try now',
                          style: TextStyle(
                            color: Color(0xFF00B14F),
                            fontSize: 8,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ));
  }
}
