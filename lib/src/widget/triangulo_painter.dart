import 'package:flutter/material.dart';

class Escalera extends StatelessWidget {
  final bool? tieneMedidaIdeal;
  final bool tieneAjuste;
  final String base;
  final String altura;
  final String hipotenusa;
  final String anguloPlataforma;
  final String anguloPisada;
  final String alturaIdeal;
  final String pisadaIdeal;
    const Escalera(
      {
        Key? key,
      this.tieneMedidaIdeal,
      required this.tieneAjuste,
      required this.base,
      required this.altura,
      required this.hipotenusa,
      required this.anguloPlataforma,
      required this.pisadaIdeal,
      required this.anguloPisada,
      required this.alturaIdeal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: double.infinity,
        height: 250,
        color: Colors.black12,
        child: CustomPaint(
          painter: TrianguloPainter(
            tieneAjuste: tieneAjuste,
            tieneMedidaIdeal: tieneMedidaIdeal,
            base: base,
            altura: altura,
            hipotenusa: hipotenusa,
            anguloPlataforma: anguloPlataforma,
            anguloPisada: anguloPisada,
            alturaIdeal: alturaIdeal,
            pisadaIdeal: pisadaIdeal,
          ),
        ),
      ),
    );
  }
}


class TrianguloPainter extends CustomPainter { 
  final bool? tieneMedidaIdeal;
  final bool tieneAjuste;
  final String base;
  final String altura;
  final String hipotenusa;
  final String anguloPlataforma;
  final String anguloPisada;
  final String alturaIdeal;
  final String pisadaIdeal;
  const TrianguloPainter(
      {
      this.tieneMedidaIdeal,
      required this.tieneAjuste,
      required this.base,
      required this.altura,
      required this.hipotenusa,
      required this.anguloPlataforma,
      required this.pisadaIdeal,
      required this.anguloPisada,
      required this.alturaIdeal});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
        paint.color = Colors.black;
    paint.strokeWidth = 4;
    paint.strokeCap = StrokeCap.round;
    paint.style = PaintingStyle.stroke;
    final path = Path();
    

    _triangulo(path, size);
    _escalon(path, size);
    if(base.compareTo("0.0") != 0){
    _anguloPlataforma(path, size);
    _texto("$base cm",canvas, size, Offset(size.width * .4, size.height * .82));
    _texto("$altura cm",canvas, size, Offset(size.width * .75, size.height * .5));
    _texto("$hipotenusa h",canvas, size, Offset(size.width * .45, size.height * .55));
    _texto("$anguloPlataforma °",canvas, size, Offset(size.width * .34, size.height * .69));
    _texto("$anguloPisada °",canvas, size, Offset(size.width * .22, size.height * .55));
    if(tieneAjuste){
       _ajuste(path, size);      
    }
    if(tieneMedidaIdeal != null && tieneMedidaIdeal!){
      _texto("$alturaIdeal cm",canvas, size, Offset(size.width * .03, size.height * .55));
    _texto("$pisadaIdeal cm",canvas, size, Offset(size.width * .3, size.height * .3));
    } else{
      _texto("La escalera no sera ideal.",canvas, size, Offset(size.width * .1, size.height * .1));
    }
}
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianguloPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(TrianguloPainter oldDelegate) => false;

  void _triangulo(Path path, Size size) {
    path.moveTo(size.width * .2, size.height * .8);
    path.lineTo(size.width * .7, size.height * .8);
    path.lineTo(size.width * .7, size.height * .3);
    path.lineTo(size.width * .2, size.height * .8);
  }
  
  void _escalon(Path path, Size size){
     path.moveTo(size.width * .2, size.height * .8);
    path.lineTo(size.width * .2, size.height * .45);
    path.lineTo(size.width * .55, size.height * .45);
  }

  void _anguloPlataforma(Path path, Size size){
    path.moveTo(size.width * .2, size.height * .68);
    path.quadraticBezierTo(size.width * .3, size.height * .6, size.width * .3, size.height * .8);
  }

  void _ajuste(Path path, Size size){
path.moveTo(size.width * .55, size.height * .45);
    path.lineTo(size.width * .66, size.height * .45);
  }

  void _texto(String texto,Canvas canvas, Size size, Offset offset) {
    TextSpan textSpan = TextSpan(
      text: texto,
      style: const TextStyle(color: Colors.black, fontSize: 15),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      maxWidth: size.width,
    );
    textPainter.paint(canvas, offset);
  }
}
