import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manfred/cubit/home_page_cubit.dart';
import 'package:manfred/cubit/home_page_state.dart';
import 'package:manfred/cubit/page_status.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => HomePageCubit()..init(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Menu principal"),
          ),
          body: BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {
              if (state.status == PageStatus.loading) {
                return Text("Cargando su información ....");
              } else if (state.status == PageStatus.failure) {
                return Text("Ha ocurrido un error: ${state.errorMessage}");
              } else {
                return Center(
                  child: // Build menu with icons
                      Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Bienvenido ${state.companyInfoDto!.companyName}"),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/newOrder');
                          },
                          child: const Text("Nuevo Pedido")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/pastOrders');
                          },
                          child: const Text("Pedidos anteriores")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/invoices');
                          },
                          child: const Text("Mis facturas")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Salir")),

                      //Boton para realizar un nuevo requerimiento
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(30)),
                          child: const Icon(
                            Icons.add,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/newRequirement');
                          }),
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}
