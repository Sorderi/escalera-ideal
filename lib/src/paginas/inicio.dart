import 'dart:math';

import 'package:escaleraideal/src/paginas/razon_pagina.dart';
import 'package:escaleraideal/src/widget/triangulo_painter.dart';
import 'package:escaleraideal/src/widget/input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextEditingController _alturaController = TextEditingController();
TextEditingController _baseController = TextEditingController();
double _pisadaIdeal = 0;
double _alturaIdeal = 0;
bool? _tieneMedidaIdeal;
bool tieneOpcionesViables = false;

class InicioPagina extends StatefulWidget {
  const InicioPagina({Key? key}) : super(key: key);

  @override
  State<InicioPagina> createState() => _InicioPaginaState();
}

class _InicioPaginaState extends State<InicioPagina> {
  // Esta variable sirve para ver el estado del formulario
  GlobalKey<FormState> formulario = GlobalKey<FormState>();

  // Definicion de variables
  double _base = 0;
  double _altura = 0;

  double _hipotenusa = 0;

  double _anguloEscalera = 0;
  double _anguloPisada = 0;

  //Creo listas(arreglos) de altura para calcular la pida
  final List<int> _alturaArreglo = [18, 19, 20, 21, 22, 23];
  final List<double> _pisadasArreglo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('La escalera perfecta'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Programa sencillo para tener la escalera de tus sueños",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Escalera(
              tieneAjuste: false,
              tieneMedidaIdeal: _tieneMedidaIdeal,
              base: _base.toString(),
              altura: _altura.toString(),
              hipotenusa: _hipotenusa.toStringAsFixed(2),
              anguloPlataforma: _anguloEscalera.toStringAsFixed(2),
              anguloPisada: _anguloPisada.toStringAsFixed(2),
              alturaIdeal: _alturaIdeal.toStringAsFixed(2),
              pisadaIdeal: _pisadaIdeal.toStringAsFixed(2),
            ),
            Form(
                key: formulario,
                child: Column(
                  children: [
                    Input(
                        label: "Ingresa la base en cm",
                        textEditingController: _baseController,
                        nombreCampo: "base",
                        hintText: "162"),
                    Input(
                        label: "Ingresa la altura en cm",
                        textEditingController: _alturaController,
                        nombreCampo: "altura",
                        hintText: "123"),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () => validacion(),
                        child: const Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                )),
            (_pisadasArreglo.isNotEmpty && !_tieneMedidaIdeal!)
                ? _ListaOpciones(
                    pisadasArreglo: _pisadasArreglo,
                    alturaArreglo: _alturaArreglo)
                : const SizedBox()
          ],
        ),
      ),
      bottomNavigationBar: (_tieneMedidaIdeal != null)
          ? TextButton(
              child: Text((_tieneMedidaIdeal!)
                  ? "¿Por que es ideal esa medida?"
                  : "¿Por que no es ideal esa medida?"),
              onPressed: () => _alertaMedida())
          : null,
    );
  }

  void validacion() {
    // Compruebo si el formulario se valido con existo
    if (formulario.currentState!.validate()) {
      // Redibujo variables
      setState(() {
        // Le asigno valor a las variables
        _base = double.parse(_baseController.text);
        _altura = double.parse(_alturaController.text);
        _calculos();
      });
    }
  }

  void _calculos() {
    // Calculo la hipotenusa elevando al cuadrado la base y altura para despues sacarle la raiz
    _hipotenusa = sqrt((pow(_base, 2) + pow(_altura, 2)));
    // Calculo el angulo de la escalera sacando la tangente inversa de la altura entrre la base para despues convertirlo a grados
    _anguloEscalera = atan(_altura / _base) * (180 / pi);
    // Para el angulo de la pisada solo es de restar 90 - el angulo de la escalera
    _anguloPisada = 90 - _anguloEscalera;
    // Limpio la lista para que  no se repitan los datos
    _pisadasArreglo.clear();
    // Realizo un ciclo para hacer las cuentas automaticas
    for (int i = 0; i < _alturaArreglo.length; i++) {
      // Calculo de la pisada: saco la tangente del angulo de la pisada, pero esta la convierto a grados para despues multiplicar por la altura
      double total = (tan((_anguloPisada * (pi / 180))) * _alturaArreglo[i]);
      // Agrego cada cuenta a otra lista (arreglo)
      if (total >= 15 && total <= 30.9) {
        _pisadasArreglo.add(total);
      }
    }
    for (int i = 0; i < _pisadasArreglo.length; i++) {
      // Valido si las medidas son validas para que sea una escalera ideal
      if (_alturaArreglo[i] >= 18 &&
          _alturaArreglo[i] <= 19 &&
          _pisadasArreglo[i] >= 30 &&
          _pisadasArreglo[i] <= 30.9) {
        _alturaIdeal = _alturaArreglo[i].toDouble();
        _pisadaIdeal = _pisadasArreglo[i];
        _tieneMedidaIdeal = true;
        break;
      } else {
        _alturaIdeal = _alturaArreglo[i].toDouble();
        _pisadaIdeal = _pisadasArreglo[i];
        _tieneMedidaIdeal = false;
        break;
      }
    }
  }

  void _alertaMedida() {
    showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text((_tieneMedidaIdeal!)
                ? "¿Por que es ideal esa medida?"
                : "¿Por que no es ideal esa medida?"),
            content: const Text(
                "La medida ideal para un escalon debe ser de 18 cm de alto y la pisada debe ser de 30 cm"),
            actions: [
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text("Cerrar"),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }
}

class _ListaOpciones extends StatelessWidget {
  const _ListaOpciones(
      {Key? key, required this.pisadasArreglo, required this.alturaArreglo})
      : super(key: key);

  final List<double> pisadasArreglo;
  final List<int> alturaArreglo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text("Opciones viables")),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pisadasArreglo.length,
            itemBuilder: (_, int i) {
              return Container(
                  color: Colors.black12,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Altura:      "),
                      Text("${alturaArreglo[i]}      ",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Text("Pisada:      "),
                      Text("${pisadasArreglo[i].toStringAsFixed(3)}      ",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ));
            }),
        SizedBox(
          width: double.infinity,
          child: TextButton(
              onPressed: () => Navigator.push(context,
                  CupertinoPageRoute(builder: (_) => const RazonPagina())),
              child: const Text("¿Por que son opciones validas?")),
        )
      ],
    );
  }
}
