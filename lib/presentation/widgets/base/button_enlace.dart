import 'package:flutter/material.dart';

class ButtonEnlace extends StatelessWidget {
  final Function onPressed;
  final String titulo;
  final Color? colorTexto;
  final bool esNegrita;
  final bool subrayado;
  final bool centrarTexto;
  final EdgeInsets? paddingBoton;

  const ButtonEnlace(
      {super.key,
      required this.onPressed,
      required this.titulo,
      this.esNegrita = false,
      this.subrayado = false,
      this.centrarTexto = false,
      this.paddingBoton,
      this.colorTexto});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: () => onPressed(),
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
          padding: MaterialStateProperty.all(paddingBoton ??
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0)),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          backgroundColor: MaterialStateProperty.all(Colors.transparent)),
      child: Padding(
        padding: paddingBoton ??
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Center(
          child: Text(titulo,
              textAlign: centrarTexto ? TextAlign.center : TextAlign.start,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  decoration: subrayado
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  color: colorTexto ?? Theme.of(context).primaryColorLight,
                  fontWeight: esNegrita ? FontWeight.w700 : FontWeight.w400)),
        ),
      ),
    );
  }
}
