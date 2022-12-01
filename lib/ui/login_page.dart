import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext ctx1) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: BlocConsumer<LoginCubit, LoginState>(
            // Se escuchan los eventos provenientes del cubit
            listener: (ctx3, state) {
              // Si el cubit dice cargando, se muestra un dialog de carga
              if (state.status == PageStatus.loading) {
                _showDialog(context, "Autenticación",
                    "Verificando sus credenciales", false);
              } else if (state.status == PageStatus.success &&
                  state.loginSuccess) {
                // Si el cubit dice que la autenticación fue exitosa, se cierra el dialog
                // y se navega a la página de inicio /home
                Navigator.pop(ctx3); // quito el dialog
                Navigator.pushNamed(ctx3, '/home');
              } else {
                // Si el cubit dice que la autenticación falló, se cierra el dialog
                // y se muestra un mensaje de error
                Navigator.pop(ctx3); // quito el dialog
                _showDialog(context, "Error", state.errorMessage!, true);
              }
            },
            // Se construye la pantalla
            builder: (context, state) => Center(child: formLogin(context)),
          )),
    );
  }

  // Método que construye el formulario o pantalla de login
  Widget formLogin(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Login"),
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            hintText: "Email",
          ),
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
            hintText: "Password",
          ),
        ),
        ElevatedButton(
            // Al presionar el botón, se envía el evento de login al cubit
            onPressed: () {
              BlocProvider.of<LoginCubit>(context)
                  .login(_usernameController.text, _passwordController.text);
            },
            child: const Text("Login")),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: const Text("Create account"))
      ],
    );
  }

  Future<void> _showDialog(BuildContext context, String title, String message,
      bool closeable) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            closeable
                ? TextButton(
                    child: const Text('Cerrar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
