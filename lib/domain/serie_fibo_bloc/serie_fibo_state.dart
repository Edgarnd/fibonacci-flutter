part of 'serie_fibo_bloc.dart';

abstract class SerieFiboState extends Equatable {
  const SerieFiboState();

  @override
  List<Object> get props => [];
}

class SerieFiboInitial extends SerieFiboState {}

class SerieFiboMatrizGeneradaState extends SerieFiboState {
  final Matriz3X3 matriz;
  const SerieFiboMatrizGeneradaState({required this.matriz});
}

class SerieFiboMatrizGiradaState extends SerieFiboState {
  final Matriz3X3 matriz;
  const SerieFiboMatrizGiradaState({required this.matriz});
}

class SerieFiboMatrizLimpiaState extends SerieFiboState {}

class SerieFiboMatrizErrorState extends SerieFiboState {}
