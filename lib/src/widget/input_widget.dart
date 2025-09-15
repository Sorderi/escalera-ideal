import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController textEditingController; 
  final String label;
  final String nombreCampo;
  final String hintText;
  const Input({Key? key, required this.label,required this.textEditingController, required this.nombreCampo,required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: textEditingController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (valor){
          String pattern = "^[0-9.]*\$";
          RegExp regExp = RegExp(pattern);
          if(valor!.isEmpty || valor == "0") return "La $nombreCampo no puede estar vacia";
          return regExp.hasMatch(valor) ? null : "La $nombreCampo solo lleva numeros";
        },
        decoration: inputDecoration(),
      ),
    );
  }
  InputDecoration inputDecoration(){
    return  InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
      label: Text(label)

    );
  }
}
