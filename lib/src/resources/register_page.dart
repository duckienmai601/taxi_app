import 'package:flutter/material.dart';

import '../blocs/auth_bloc.dart';
import 'dialog/loading_dialog.dart';
import 'dialog/msg_dialog.dart';
import 'home_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc authBloc = AuthBloc();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Nền trắng cho AppBar
        elevation: 0, // Loại bỏ bóng mờ
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Quay lại trang trước
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 140,
              ),
              Image.asset('assets/img/ic_car_red.png'),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 6),
                child: Text(
                  "Welcome Aboard!",
                  style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                ),
              ),
              const Text(
                "Signup with iCab in simple steps",
                style: TextStyle(fontSize: 16, color: Color(0xff606470)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
                child: StreamBuilder(
                    stream: authBloc.nameStream,
                    builder: (context, snapshot) => TextField(
                      controller: _nameController,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                          labelText: "Name",
                          prefixIcon: SizedBox(
                              width: 50, child: Image.asset("assets/img/ic_user.png")),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),
                              borderRadius:
                              BorderRadius.all(Radius.circular(6)))),
                    )),
              ),
              StreamBuilder(
                  stream: authBloc.phoneStream,
                  builder: (context, snapshot) => TextField(
                    controller: _phoneController,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Phone Number",
                        errorText:
                        snapshot.hasError ? snapshot.error.toString() : null,
                        prefixIcon: SizedBox(
                            width: 50, child: Image.asset("assets/img/ic_phone.png")),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffCED0D2), width: 1),
                            borderRadius:
                            BorderRadius.all(Radius.circular(6)))),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: StreamBuilder(
                    stream: authBloc.emailStream,
                    builder: (context, snapshot) => TextField(
                      controller: _emailController,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Email",
                          errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                          prefixIcon: SizedBox(
                              width: 50, child: Image.asset("assets/img/ic_mail.png")),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),
                              borderRadius:
                              BorderRadius.all(Radius.circular(6)))),
                    )),
              ),
              StreamBuilder(
                  stream: authBloc.passStream,
                  builder: (context, snapshot) => TextField(
                    controller: _passController,
                    obscureText: true,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        errorText:
                        snapshot.hasError ? snapshot.error.toString() : null,
                        labelText: "Password",
                        prefixIcon: SizedBox(
                            width: 50, child: Image.asset("assets/img/ic_lock.png")),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffCED0D2), width: 1),
                            borderRadius:
                            BorderRadius.all(Radius.circular(6)))),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _onSignUpClicked,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3277D8), // background color
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ),
                    child: const Text(
                      "Signup",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: RichText(
                  text: const TextSpan(
                      text: "Already a User? ",
                      style: TextStyle(color: Color(0xff606470), fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Login now",
                            style: TextStyle(
                                color: Color(0xff3277D8), fontSize: 16))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onSignUpClicked() {
    var isValid = authBloc.isValid(
      _nameController.text,
      _emailController.text,
      _passController.text,
      _phoneController.text,
    );

    if (isValid) {
      // Hiển thị Loading Dialog
      LoadingDialog.showLoadingDialog(context, 'Loading...');

      // Thực hiện đăng ký
      authBloc.signUp(
        _emailController.text,
        _passController.text,
        _phoneController.text,
        _nameController.text,
            () {
          // Khi đăng ký thành công
          if (context.mounted) { // Đảm bảo context còn tồn tại
            LoadingDialog.hideLoadingDialog(context); // Ẩn Loading Dialog
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
            (msg) {
          // Khi có lỗi
          if (context.mounted) {
            LoadingDialog.hideLoadingDialog(context); // Ẩn Loading Dialog
            MsgDialog.showMsgDialog(context, "Sign-Up Error", msg); // Hiển thị thông báo lỗi
          }
        },
      );
    } else {
      // Nếu thông tin không hợp lệ
      MsgDialog.showMsgDialog(context, "Input Error", "Please check your input fields.");
    }
  }




}
