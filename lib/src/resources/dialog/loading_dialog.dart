import 'package:flutter/material.dart';

class LoadingDialog {
  static void showLoadingDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      barrierDismissible: false, // Ngăn không cho người dùng thoát khi nhấn ra ngoài
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent, // Làm nền trong suốt
        child: Container(
          color: const Color(0xffffffff), // Màu nền của dialog
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  msg,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Sửa hideLoadingDialog không cần tham số
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(); // Không cần tham số
  }
}
