import 'package:fibonacci/presentation/dialogs/dialogos.dart';
import 'package:flutter/material.dart';

class DialogosApp extends Dialogos {
  Future<void> dialogoInfo(
      {required BuildContext context,
      required String titulo,
      required String mensaje}) async {
    await dialogoBase(
        mostrarIcono: true,
        iconoDato: Icons.info_outline_rounded,
        context: context,
        titulo: titulo,
        mensaje: mensaje,
        textoAccionPrimaria: "Aceptar");
  }
}
