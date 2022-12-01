import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Creación de nueva cuenta"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Ingrese sus datos"),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: "Contraseña",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/companyRegister');
                },
                child: const Text("Crear cuenta de empresa")),
            ElevatedButton(
                onPressed: () {},
                child: const Text("Crear cuenta como persona"))
          ],
        ),
      ),
    );
  }
}
