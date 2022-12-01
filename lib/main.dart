import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manfred/ui/home_page.dart';
import 'package:manfred/ui/login_page.dart';
import 'package:manfred/ui/company_register_page.dart';
import 'package:manfred/ui/register_page.dart';

import 'cubit/app_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit(),
        child: MaterialApp(
          title: 'Pedidos Ya!',
          theme: ThemeData(
            // This is the theme of your application.
            primarySwatch: Colors.purple,
          ),
          initialRoute: "/",
          routes: {
            "/": (context) => const LoginPage(),
            "/home": (context) => const HomePage(),
            "/companyRegister": (context) => const CompanyRegisterPage(),
            "/register": (context) => const RegisterPage(),
          },
        ));
  }
}
