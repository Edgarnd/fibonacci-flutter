import 'package:fibonacci/data/models/matriz_3x3_model.dart';
import 'package:flutter/material.dart';

class MatrizWidget extends StatefulWidget {
  final ValueNotifier<Matriz3X3> nMatriz;
  const MatrizWidget({super.key, required this.nMatriz});

  @override
  State<MatrizWidget> createState() => _MatrizWidgetState();
}

class _MatrizWidgetState extends State<MatrizWidget> {
  final double _espacioEntreFila = 15.0;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.nMatriz,
        builder: (context, valor, child) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
            child: Table(
              children: [
                TableRow(
                    children: widget.nMatriz.value.fila1
                        .map((e) => Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: _espacioEntreFila),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  e.toString(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            ))
                        .toList()),
                TableRow(
                    children: widget.nMatriz.value.fila2
                        .map((e) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: _espacioEntreFila),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                e.toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            )))
                        .toList()),
                TableRow(
                    children: widget.nMatriz.value.fila3
                        .map((e) => Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: _espacioEntreFila),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  e.toString(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            ))
                        .toList()),
              ],
            ),
          );
        });
  }
}
