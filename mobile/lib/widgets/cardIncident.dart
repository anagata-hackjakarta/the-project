import 'package:flutter/material.dart';

import '../config/them.dart';

class Cardincident extends StatelessWidget {
  const Cardincident({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: EdgeInsets.only(right: 10),
        width: MediaQuery.of(context).size.width / 2.5,
        // border shadow 1 px
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF000000).withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              // offset: Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Speeding',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '2 incidents',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    'See details',
                    style: TextStyle(
                      color: Color(0xFF00B14F),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Image(
                    image: AssetImage(
                        'assets/images/ic_arrow.png'),
                    color: ThemeConfig.primaryColor,
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}
