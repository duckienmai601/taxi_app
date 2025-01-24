import 'package:flutter/material.dart';

class MsgDialog {
  // Hàm hiển thị thông báo (AlertDialog)
  static void showMsgDialog(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // Tiêu đề của dialog
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold), // Định dạng tiêu đề
        ),
        // Nội dung thông báo
        content: Text(msg),
        // Các hành động của dialog
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog khi nhấn "OK"
            },
          ),
        ],
        // Thêm borderRadius cho AlertDialog (tùy chỉnh góc bo)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        // Thêm màu nền cho dialog
        backgroundColor: Colors.white,
      ),
    );
  }
}
