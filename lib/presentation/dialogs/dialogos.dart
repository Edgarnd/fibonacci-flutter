import 'package:fibonacci/presentation/anims/fade_in_down.dart';
import 'package:fibonacci/presentation/widgets/base/button_defecto.dart';
import 'package:fibonacci/presentation/widgets/base/button_enlace.dart';
import 'package:flutter/material.dart';

class Dialogos {
  static const EdgeInsets insetsPaddingCustom =
      EdgeInsets.symmetric(horizontal: 25.0);
  static const EdgeInsets titlePaddingCustom =
      EdgeInsets.only(left: 25.0, right: 25.0, top: 35.0, bottom: 20.0);
  static const EdgeInsets contentPaddingCustom =
      EdgeInsets.symmetric(horizontal: 30.0);
  static const EdgeInsets actionsPaddingCustom =
      EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0);
  static const RoundedRectangleBorder radiusDialogCustom =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)));

  Future<void> dialogoBase(
      {required BuildContext context,
      required String titulo,
      required String mensaje,
      required String textoAccionPrimaria,
      Widget widgetContenido = const SizedBox.shrink(),
      Widget widgetArribaTitulo = const SizedBox.shrink(),
      String textoAccionSecundaria = "",
      IconData? iconoDato,
      Color? colorIcono,
      bool mostrarIcono = false,
      bool tituloNegrita = false,
      double? tamanioLetraMensaje,
      double tamanioLetraBoton = 16.0,
      bool letraNegrita = false,
      bool subrayado = false,
      EdgeInsets paddingLetraBoton = EdgeInsets.zero,
      Function? accionPrimaria,
      Function? accionSecundaria}) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: true,
        builder: (context) {
          return WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: FadeInDown(
                child: AlertDialog(
                  insetPadding: insetsPaddingCustom,
                  titlePadding: titlePaddingCustom,
                  contentPadding: contentPaddingCustom,
                  actionsPadding: actionsPaddingCustom,
                  shape: radiusDialogCustom,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widgetArribaTitulo,
                      Visibility(
                        visible: mostrarIcono && iconoDato != null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              iconoDato,
                              size: 38.0,
                              color: colorIcono ??
                                  Theme.of(context).primaryColorLight,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: mostrarIcono && iconoDato != null,
                        child: const SizedBox(height: 20.0),
                      ),
                      Text(titulo,
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 18.0,
                                  fontWeight: tituloNegrita
                                      ? FontWeight.w900
                                      : FontWeight.w700)),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: mensaje.isNotEmpty,
                        child: Flexible(
                          child: Text(
                            mensaje,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .overline!
                                        .color!),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: mensaje.isEmpty &&
                              widgetContenido != const SizedBox.shrink(),
                          child: widgetContenido),
                      SizedBox(
                          height: 1.0, width: MediaQuery.of(context).size.width)
                    ],
                  ),
                  actions: [
                    Visibility(
                      visible: textoAccionPrimaria.isNotEmpty,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonDefecto(
                              esNegrita: letraNegrita,
                              tamanioLetra: tamanioLetraBoton,
                              paddingBoton: paddingLetraBoton,
                              onPressed: () => accionPrimaria != null
                                  ? accionPrimaria()
                                  : Navigator.pop(context),
                              titulo: textoAccionPrimaria),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: textoAccionPrimaria.isNotEmpty &&
                            textoAccionSecundaria.isNotEmpty,
                        child: const SizedBox(height: 10.0)),
                    Visibility(
                      visible: textoAccionSecundaria.isNotEmpty,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: 45.0,
                                maxWidth:
                                    MediaQuery.of(context).size.width / 2.25),
                            child: ButtonEnlace(
                                colorTexto:
                                    Theme.of(context).secondaryHeaderColor,
                                esNegrita: letraNegrita,
                                subrayado: subrayado,
                                paddingBoton: paddingLetraBoton,
                                onPressed: () => accionSecundaria != null
                                    ? accionSecundaria()
                                    : Navigator.pop(context),
                                titulo: textoAccionSecundaria),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
