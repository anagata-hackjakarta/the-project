import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safina/config/them.dart';
import 'package:safina/controllers/popUpController.dart';
import 'package:safina/widgets/safinaButton.dart';

class Playscreen extends StatelessWidget {
  final PopupController controller = Get.put(PopupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeConfig.primaryColor,
        title: Text('Live Tracking', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              // background full image cover size
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/img_map.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Speed', style: TextStyle(fontSize: 20)),
                      Obx(() => Text('${controller.speed.value} km/h',
                          style: TextStyle(fontSize: 20))),
                    ],
                  ),
                ),
                // create line like hr
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                Obx(
                  () => Container(
                    // shadow like card
                    // height 20% from screen
                    height: Get.height * 0.15,
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.alertList.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(
                              controller.alertList[index].severity?.toUpperCase() == 'SEVERE'
                                  ? Icons.error
                                  : controller.alertList[index].severity?.toUpperCase() == 'MODERATE'
                                      ? Icons.warning
                                      : Icons.info,
                              color: controller.alertList[index].severity?.toUpperCase() == 'SEVERE'
                                  ? Colors.red
                                  : controller.alertList[index].severity?.toUpperCase() == 'MODERATE'
                                  ? Colors.orange
                                  : Colors.blue,
                            ),
                            title: Text(controller.alertList[index].severity ??
                                'Unknown severity'),
                            subtitle: Text(
                                controller.alertList[index].description ??
                                    'No description available'),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            )),
          )
        ],
      ),
      floatingActionButton: SafinaButton(),
    );
  }
}
