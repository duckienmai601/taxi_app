import 'package:flutter/material.dart';
import 'package:taxi_application/src/resources/login_page.dart';

import 'blocs/auth_bloc.dart';

class MyApp extends StatelessWidget {
  final AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Application',
      home: LoginPage(authBloc: authBloc), // Truyền authBloc vào LoginPage
    );
  }
}
