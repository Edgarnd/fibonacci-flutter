part of 'serie_fibo_bloc.dart';

abstract class SerieFiboEvent extends Equatable {
  const SerieFiboEvent();

  @override
  List<Object> get props => [];
}

class GenerarMatrizFiboEvent extends SerieFiboEvent {
  final int elementoInicial;
  final int elementoFinal;
  const GenerarMatrizFiboEvent(
      {required this.elementoInicial, required this.elementoFinal});
}

class GirarMatrizFiboEvent extends SerieFiboEvent {
  final GiroMatriz giroMatriz;
  final Matriz3X3 matriz;
  const GirarMatrizFiboEvent({required this.giroMatriz, required this.matriz});
}

class LimpiarMatrizFiboEvent extends SerieFiboEvent {}

enum GiroMatriz { derecha, izquierda }
