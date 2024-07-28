import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/popUpController.dart';

class SafinaButton extends StatelessWidget {
  final PopupController popupController = Get.put(PopupController());

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(
        heroTag: "add image",
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: popupController.showPopup,
        child: Image.asset("assets/images/ic_safina.png", fit: BoxFit.cover)
    );
  }
}
