import 'package:flutter/material.dart';

class CardSummary extends StatelessWidget {
  const CardSummary({super.key});

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
                      'assets/images/ic_motor.png',
                      width: 50,
                    ),
                    Container(
                      // width: 70% width of the screen,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        'Your braking was hard and sudden. Brake more smoothly.',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
