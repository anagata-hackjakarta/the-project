import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safina/config/them.dart';
import 'package:safina/controllers/popUpController.dart';
import 'package:safina/widgets/bannerList.dart';
import 'package:safina/widgets/cardRobot.dart';

import '../controllers/loginController.dart';
import '../widgets/listMenu.dart';
import '../widgets/safinaButton.dart';

class HomeScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: ThemeConfig.primaryColor,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(32),
                    //   topRight: Radius.circular(32),
                    // ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Analyze your driving behavior with AI",
                                      style: TextStyle(
                                        color: Colors.white,
                                        // fontsize 20% on screen
                                        fontSize: 21.0,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Try now',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Image.asset(
                                          'assets/images/ic_arrow.png',
                                          width: 20.0,
                                          height: 20.0,
                                        ),
                                      ]
                                    )
                                  ],
                                )),
                            Expanded(
                              flex: 6,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/img_driver.png'),
                                    fit: BoxFit
                                        .fitHeight, // Make the image cover the entire box
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Balance',
                            style: TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: ThemeConfig.secondaryFontColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Rp. 1.500.000',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Image.asset(
                                'assets/images/ic_eye.png',
                                width: 20.0,
                                height: 20.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  // color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(height: 32),
                      ListMenu(),
                      SizedBox(height: 32),
                      Text(
                        'What’s New',
                        style: TextStyle(
                          color: Color(0xFF16171A),
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      SizedBox(height: 5),
                      CardRobot(),
                      SizedBox(height: 30),
                      Text(
                        'Analysis for You',
                        style: TextStyle(
                          color: Color(0xFF16171A),
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      SizedBox(height: 5),
                      Bannerlist()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: SafinaButton(),
    );
  }
}
