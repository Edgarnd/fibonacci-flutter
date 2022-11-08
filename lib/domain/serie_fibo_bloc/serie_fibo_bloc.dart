import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fibonacci/data/models/matriz_3x3_model.dart';

part 'serie_fibo_event.dart';
part 'serie_fibo_state.dart';

class SerieFiboBloc extends Bloc<SerieFiboEvent, SerieFiboState> {
  SerieFiboBloc() : super(SerieFiboInitial()) {
    on<SerieFiboEvent>((event, emit) {});
    on<GenerarMatrizFiboEvent>(_generarMatriz);
    on<GirarMatrizFiboEvent>(_girarMatriz);
    on<LimpiarMatrizFiboEvent>(_limpiarMatriz);
  }

  Future<void> _generarMatriz(
      GenerarMatrizFiboEvent event, Emitter<SerieFiboState> emit) async {
    emit(SerieFiboInitial());
    try {
      if ((event.elementoFinal - event.elementoInicial) != 8) {
        emit(SerieFiboMatrizErrorState());
        return;
      }
      List<int> fibo = [];

      int pAtrasDe = 0;
      int pAtras = 0;
      int pActual = 0;

      int pInitialSerie = event.elementoInicial;
      for (int i = 0; i < pInitialSerie; i++) {
        if (i == 1) pAtrasDe = 1;
        pActual = pAtras + pAtrasDe;
        pAtrasDe = pAtras;
        pAtras = pActual;
      }

      int pFinalSerie = event.elementoFinal;
      for (int i = pInitialSerie; i <= pFinalSerie; i++) {
        if (fibo.length == 1 && fibo.first == 0) pAtrasDe = 1;
        pActual = pAtras + pAtrasDe;
        pAtrasDe = pAtras;
        pAtras = pActual;
        fibo.add(pActual);
      }
      Matriz3X3 matriz = Matriz3X3(
        fila1: fibo.sublist(0, 3),
        fila2: fibo.sublist(3, 6),
        fila3: fibo.sublist(6, 9),
      );
      emit(SerieFiboMatrizGeneradaState(matriz: matriz));
    } catch (e) {
      emit(SerieFiboMatrizErrorState());
    }
  }

  Future<void> _girarMatriz(
      GirarMatrizFiboEvent event, Emitter<SerieFiboState> emit) async {
    emit(SerieFiboInitial());
    try {
      Matriz3X3 matrizOriginal = event.matriz;
      if ([
        ...matrizOriginal.fila1,
        ...matrizOriginal.fila2,
        ...matrizOriginal.fila3
      ].every((element) => element == 0)) {
        emit(SerieFiboMatrizErrorState());
      }
      switch (event.giroMatriz) {
        case GiroMatriz.derecha:
          Matriz3X3 matrizGirada = Matriz3X3(fila1: [
            matrizOriginal.fila3[0],
            matrizOriginal.fila2[0],
            matrizOriginal.fila1[0]
          ], fila2: [
            matrizOriginal.fila3[1],
            matrizOriginal.fila2[1],
            matrizOriginal.fila1[1]
          ], fila3: [
            matrizOriginal.fila3[2],
            matrizOriginal.fila2[2],
            matrizOriginal.fila1[2]
          ]);
          emit(SerieFiboMatrizGiradaState(matriz: matrizGirada));
          break;
        case GiroMatriz.izquierda:
          Matriz3X3 matrizGirada = Matriz3X3(fila1: [
            matrizOriginal.fila1[2],
            matrizOriginal.fila2[2],
            matrizOriginal.fila3[2]
          ], fila2: [
            matrizOriginal.fila1[1],
            matrizOriginal.fila2[1],
            matrizOriginal.fila3[1]
          ], fila3: [
            matrizOriginal.fila1[0],
            matrizOriginal.fila2[0],
            matrizOriginal.fila3[0]
          ]);
          emit(SerieFiboMatrizGiradaState(matriz: matrizGirada));
          break;
      }
    } catch (e) {
      emit(SerieFiboMatrizErrorState());
    }
  }

  Future<void> _limpiarMatriz(
      LimpiarMatrizFiboEvent event, Emitter<SerieFiboState> emit) async {
    emit(SerieFiboInitial());
    emit(SerieFiboMatrizLimpiaState());
  }
}
