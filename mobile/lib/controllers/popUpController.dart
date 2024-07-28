import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:safina/model/analyzeRequestModel.dart';
import 'package:safina/model/analyzeResponseModel.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../services/Service.dart';
import '../widgets/alertScreen.dart';

class PopupController extends GetxController {
  var isVisible = false.obs;

  final speed = 0.0.obs;
  final RxList<Alerts> alertList = <Alerts>[].obs;
  final onListen = false.obs;

  var accelerometerValues = <double>[0, 0, 0].obs;
  var gyroscopeValues = <double>[0, 0, 0].obs;
  var magnetometerValues = <double>[0, 0, 0].obs;

  final ScrollController scrollController = ScrollController();

// This is what you're looking for!
  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  final AudioPlayer audioPlayer = AudioPlayer();

  // create function generate random number
  String generateRandomNumber() {
    String randomUUID = "";
    for (int i = 0; i < 10; i++) {
      randomUUID += (i + 1).toString();
    }
    return randomUUID;
  }

  @override
  void onReady() {
    onListen.value = true;
    startInterval();
    super.onReady();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // Listen to sensor events
    accelerometerEventStream().listen((AccelerometerEvent event) {
      accelerometerValues.value = [event.x, event.y, event.z];
    });

    gyroscopeEventStream().listen((GyroscopeEvent event) {
      gyroscopeValues.value = [event.x, event.y, event.z];
    });

    magnetometerEventStream().listen((MagnetometerEvent event) {
      magnetometerValues.value = [event.x, event.y, event.z];
    });
  }

  @override
  void onClose() {
    onListen.value = false;
    super.onClose();
  }

  // interval function
  void startInterval() {
    intervalHitApi();
    Future.delayed(Duration(seconds: 5), () {
        startInterval();
    });
}

void showPopup() async {
  await audioPlayer.play(AssetSource('sounds/alert.mp3'));

  isVisible.value = true;
  Get.dialog(
    AlertScreen(),
    barrierDismissible: false,
  );

  if (await Vibrate.canVibrate) {
    Vibrate.vibrate();
  }

  Future.delayed(Duration(seconds: 3), () {
    if (isVisible.value) {
      Get.back();
      isVisible.value = false;
    }
  });
}

// create function to interval hit api service one 3 second
void intervalHitApi() async {
  // create function to interval hit api service one 3 second
  AnalyzeRequestModel requestData = AnalyzeRequestModel();

  requestData.uid = generateRandomNumber();
  requestData.tripId = generateRandomNumber();
  requestData.timestamp = DateTime.now().toIso8601String();

  Location location = new Location();
  location.lat = 40.7128;
  location.lon = -74.0060;
  requestData.location = location;

  Speed speed = new Speed();
  speed.current = 50;
  requestData.speed = speed;

  Accelerometer accelerometer = new Accelerometer();
  accelerometer.x = accelerometerValues.value[0];
  accelerometer.y = accelerometerValues.value[1];
  accelerometer.z = accelerometerValues.value[2];
  requestData.accelerometer = accelerometer;

  Gyroscope gyroscope = new Gyroscope();
  gyroscope.roll = gyroscopeValues.value[0];
  gyroscope.pitch = gyroscopeValues.value[1];
  gyroscope.yaw = gyroscopeValues.value[2];
  requestData.gyroscope = gyroscope;

  LaneChange laneChange = new LaneChange();
  laneChange.count = 0;
  requestData.laneChange = laneChange;

  Turning turning = new Turning();
  turning.leftTurns = 0;
  turning.rightTurns = 0;
  requestData.turning = turning;

  Deceleration deceleration = new Deceleration();
  deceleration.count = 1;
  deceleration.averageDeceleration = -0.5;
  requestData.deceleration = deceleration;

  print("Request");
  print(requestData.toJson());

  AnalyzeResponseModel analyze = await Services.anlyze(requestData);
  if (analyze != null) {
    if (analyze.alerts != null) {
      for (var alert in analyze.alerts!) {
        alertList.add(alert);
        if (alert.severity?.toUpperCase() == "SEVERE") {
          showPopup();
        }
      }
      _scrollDown();
    }
  }

  print("Response");
  print(analyze.toJson());
}}
