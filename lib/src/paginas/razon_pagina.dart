import 'package:escaleraideal/src/widget/triangulo_painter.dart';
import 'package:flutter/material.dart';

class RazonPagina extends StatelessWidget {
  const RazonPagina({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("¿Por que son opciones validas?"),
      ),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
                "Estas opciones podrían ser válidas si le damos un pequeño ajuste, el cual es aumentar de 4 a 5 cm a la pisada, ejemplo:"),
          ),
          Escalera(
            base: "256",
            altura: "338",
            hipotenusa: "424.00",
            anguloPlataforma: "52.85",
            pisadaIdeal: "15.90",
            anguloPisada: "37.14",
            alturaIdeal: "21",
            tieneMedidaIdeal: true,
            tieneAjuste: true,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
                "Así se vería la escalera modificada, lo que sucede es que la punta del pie ya estaría debajo del siguiente escalón, si no nos excedemos no habrá mucho problema con la escalera."),
          ),
          
        ],
      ),
    );
  }
}
