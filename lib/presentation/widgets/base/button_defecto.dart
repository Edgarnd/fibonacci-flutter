import 'package:flutter/material.dart';

class ButtonDefecto extends StatefulWidget {
  final ValueNotifier<bool>? notificarBotonActivo;
  final Function onPressed;
  final Function? onLongPress;
  final String titulo;
  final Color? colorTexto;
  final Color? colorBoton;
  final bool esNegrita;
  final EdgeInsets paddingBoton;
  final double tamanioLetra;

  const ButtonDefecto(
      {super.key,
      required this.onPressed,
      required this.titulo,
      this.onLongPress,
      this.colorBoton,
      this.notificarBotonActivo,
      this.esNegrita = false,
      this.tamanioLetra = 16.0,
      this.paddingBoton =
          const EdgeInsets.symmetric(horizontal: 35.0, vertical: 8.0),
      this.colorTexto});

  @override
  State<ButtonDefecto> createState() => _ButtonDefectoState();
}

class _ButtonDefectoState extends State<ButtonDefecto> {
  ValueNotifier<bool> _notificarBotonActivo = ValueNotifier<bool>(true);
  @override
  void initState() {
    if (widget.notificarBotonActivo != null) {
      _notificarBotonActivo = widget.notificarBotonActivo!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _notificarBotonActivo,
        builder: (context, valor, child) {
          return ElevatedButton(
              onPressed:
                  _notificarBotonActivo.value ? () => widget.onPressed() : null,
              onLongPress:
                  _notificarBotonActivo.value && widget.onLongPress != null
                      ? () {
                          widget.onLongPress!();
                        }
                      : null,
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  minimumSize:
                      MaterialStateProperty.all(const Size(200.0, 50.0)),
                  maximumSize:
                      MaterialStateProperty.all(const Size(250.0, 50.0)),
                  backgroundColor: MaterialStateProperty.all(
                      _notificarBotonActivo.value
                          ? widget.colorBoton
                          : Theme.of(context).disabledColor)),
              child: Padding(
                padding: widget.paddingBoton,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(widget.titulo,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: widget.tamanioLetra,
                          letterSpacing: widget.esNegrita ? 0.5 : null,
                          color: _notificarBotonActivo.value
                              ? widget.colorTexto ?? Colors.white
                              : Colors.white,
                          fontWeight: widget.esNegrita
                              ? FontWeight.w900
                              : FontWeight.w700)),
                ),
              ));
        });
  }
}
