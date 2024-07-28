import 'package:flutter/material.dart';

class CardNotif extends StatelessWidget {
  const CardNotif({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          // add elevation 1
          boxShadow: [
            BoxShadow(
              color: Color(0xFF000000).withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          border: Border(
            left: BorderSide(
              color: Colors.red,
              width: 4,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Severe',
                style: TextStyle(
                  color: Color(0xFFE13600),
                  fontSize: 8,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.speed, color: Colors.red,),
                  SizedBox(width: 8),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      'WATCHOUT!',
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                      ),
                    ),
                  )
                ],
              ),
              Text("You rapidly accelerated from 0 to 60 km/h in 3 seconds.\n\nAvoid rapid acceleration to ensure smoother and safer driving."),
              SizedBox(height: 8),
              Text(
                '25-07-2024 17:15:59',
                style: TextStyle(
                  color: Color(0xFF81868E),
                  fontSize: 8,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              )
            ],
          ),
        )
    );
  }
}
