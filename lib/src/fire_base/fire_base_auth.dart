import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirAuth {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  Future<void> signUp(String email, String pass, String phone, String name,
      Function onSuccess, Function(String) onRegisterError) async {
    try {
      // Tạo người dùng bằng email và mật khẩu
      UserCredential userCredential = await _fireBaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);

      // Lấy đối tượng User từ UserCredential
      User? user = userCredential.user;

      if (user != null) {
        // Đảm bảo rằng user không null, sau đó gọi hàm tạo người dùng
        await _createUser(user.uid, name, phone, onSuccess, onRegisterError);
      } else {
        // Nếu không có người dùng, gọi onRegisterError
        onRegisterError("Failed to get user details.");
      }
    } catch (err) {
      // Kiểm tra lỗi và xử lý nếu lỗi là FirebaseAuthException
      if (err is FirebaseAuthException) {
        print("Error: " + err.code); // In mã lỗi
        _onSignUpErr(err.code, onRegisterError);
      } else {
        print("Error: " + err.toString()); // In lỗi chung
        onRegisterError("An unexpected error occurred.");
      }
    }
  }




  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _fireBaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      onSuccess();
    }).catchError((err) {
      print("err: $err");
      onSignInError("Sign-In fail, please try again");
    });
  }

  _createUser(String userId, String name, String phone, Function onSuccess,
      Function(String) onRegisterError) {
    var user = <String, String>{};
    user["name"] = name;
    user["phone"] = phone;

    var ref = FirebaseDatabase.instance.ref().child("users");
    ref.child(userId).set(user).then((vl) {
      print("on value: SUCCESSED");
      onSuccess();
    }).catchError((err) {
      print("err: $err");
      onRegisterError("SignUp fail, please try again");
    }).whenComplete(() {
      print("completed");
    });
  }

  ///

  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("SignUp fail, please try again");
        break;
    }
  }

  Future<void> signOut() async {
    print("signOut");
    return _fireBaseAuth.signOut();
  }
}