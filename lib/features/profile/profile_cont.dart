import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  List user = Get.arguments;
  showBottomSheet() {
    Get.bottomSheet(
      SizedBox(
        height: 150,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Choose Profile Picture',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Column(
                    children: const [
                      Icon(
                        Icons.photo,
                        size: 30,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Gallery'),
                    ],
                  ),
                  onTap: () {},
                ),
                const SizedBox(
                  width: 60,
                ),
                InkWell(
                  child: Column(
                    children: const [
                      Icon(
                        Icons.camera,
                        size: 30,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Camera')
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
