import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

//import '../cubit/page_status.dart';

class CompanyRegisterPage extends StatefulWidget {
  const CompanyRegisterPage({Key? key}) : super(key: key);

  @override
  State<CompanyRegisterPage> createState() => _CompanyRegisterPageState();
}

class _CompanyRegisterPageState extends State<CompanyRegisterPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _websiteController = TextEditingController();
  final _managerNameController = TextEditingController();
  final _managerNumberController = TextEditingController();

  @override
  Widget build(BuildContext ctx1) {
    return BlocProvider(
      create: (context) => RegisterCompanyCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: BlocConsumer<RegisterCompanyCubit, RegisterCompanyState>(
            // Se escuchan los eventos provenientes del cubit
            listener: (ctx3, state) {
              // Si el cubit dice cargando, se muestra un dialog de carga
              if (state.status == PageStatus.loading) {
                _showDialog(context, "Nueva cuenta",
                    "Creando cuenta de empresa", false);
              } else if (state.status == PageStatus.success &&
                  state.registerSuccess) {
                // Si el cubit dice que la autenticación fue exitosa, se cierra el dialog
                // y se navega a la página de login /
                Navigator.pop(ctx3); // quito el dialog
                Navigator.pushNamed(ctx3, '/');
              } else {
                // Si el cubit dice que la autenticación falló, se cierra el dialog
                // y se muestra un mensaje de error
                Navigator.pop(ctx3); // quito el dialog
                _showDialog(context, "Error", state.errorMessage!, true);
              }
            },
            // Se construye la pantalla
            builder: (context, state) => Center(child: formRegister(context)),
          )),
    );
  }

  // Método que construye el formulario o pantalla de login
  Widget formRegister(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Registro de empresa"),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            hintText: "Nombre de la empresa",
          ),
        ),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            hintText: "Describe a tu empresa",
          ),
        ),
        TextField(
          controller: _websiteController,
          decoration: const InputDecoration(
            hintText: "Sitio web",
          ),
        ),
        TextField(
          controller: _managerNameController,
          decoration: const InputDecoration(
            hintText: "Nombre del encargado",
          ),
        ),
        TextField(
          controller: _managerNumberController,
          decoration: const InputDecoration(
            hintText: "Número de contacto",
          ),
        ),
        ElevatedButton(
            // Al presionar el botón, se envía el evento de login al cubit
            onPressed: () {
              int _managerPhoneNumberController =
                  int.parse(_managerNumberController.text);
              BlocProvider.of<RegisterCompanyCubit>(context).registerCompany(
                  _nameController.text,
                  _descriptionController.text,
                  _websiteController.text,
                  _managerNameController.text,
                  _managerPhoneNumberController);
            },
            child: const Text("Crear cuenta")),
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
