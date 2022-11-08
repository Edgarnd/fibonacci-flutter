import 'package:fibonacci/data/models/matriz_3x3_model.dart';
import 'package:flutter/material.dart';

class SumaMatrizWidget extends StatelessWidget {
  final ValueNotifier<Matriz3X3> nMatriz;
  const SumaMatrizWidget({super.key, required this.nMatriz});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: nMatriz,
      builder: ((context, value, child) {
        return Text(
          "Suma de matriz: ${[
            ...nMatriz.value.fila1,
            ...nMatriz.value.fila2,
            ...nMatriz.value.fila3
          ].reduce((a, b) => a + b)}",
          style:
              Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16.0),
        );
      }),
    );
  }
}
