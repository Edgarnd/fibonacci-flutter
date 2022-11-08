import 'package:fibonacci/data/models/matriz_3x3_model.dart';
import 'package:fibonacci/domain/serie_fibo_bloc/serie_fibo_bloc.dart';
import 'package:fibonacci/presentation/dialogs/dialogos_app.dart';
import 'package:fibonacci/presentation/utils/datos_tema.dart';
import 'package:fibonacci/presentation/widgets/base/button_defecto.dart';
import 'package:fibonacci/presentation/widgets/base/theme_switcher.dart';
import 'package:fibonacci/presentation/widgets/home/matriz_widget.dart';
import 'package:fibonacci/presentation/widgets/home/suma_matriz_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _controladorInicial = TextEditingController();
  final TextEditingController _controladorFinal = TextEditingController();
  final FocusNode _focoInicial = FocusNode();
  final FocusNode _focoFinal = FocusNode();
  final DialogosApp _dialogosApp = DialogosApp();
  static final Matriz3X3 _matrizVacia = Matriz3X3(
    fila1: [0, 0, 0],
    fila2: [0, 0, 0],
    fila3: [0, 0, 0],
  );
  final ValueNotifier<Matriz3X3> _nMatriz = ValueNotifier(_matrizVacia);
  final ValueNotifier<bool> _nActBtnLimpie = ValueNotifier(false);
  final ValueNotifier<bool> _nActBtnGenerar = ValueNotifier(false);

  void verificarBtnGenerar() {
    _nActBtnGenerar.value = _controladorInicial.text.isNotEmpty &&
        _controladorFinal.text.isNotEmpty;
  }

  @override
  void initState() {
    _controladorInicial.addListener(verificarBtnGenerar);
    _controladorFinal.addListener(verificarBtnGenerar);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Matriz de Fibonacci"),
        actions: [
          IconButton(
              onPressed: () {
                ThemeSwitcher.of(context).switchTheme(
                    ThemeSwitcher.of(context).themeData!.brightness ==
                            Brightness.dark
                        ? DatosTemas.modoClaro
                        : DatosTemas.modoOscuro);
              },
              icon: Icon(
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Icons.light_mode
                      : Icons.dark_mode))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
              valueListenable: _nMatriz,
              builder: (context, value, child) {
                return BlocListener<SerieFiboBloc, SerieFiboState>(
                  listener: (context, estado) {
                    if (estado is SerieFiboMatrizGeneradaState) {
                      _nMatriz.value = estado.matriz;
                      _nActBtnLimpie.value = true;
                    }
                    if (estado is SerieFiboMatrizLimpiaState) {
                      _nMatriz.value = _matrizVacia;
                    }
                    if (estado is SerieFiboMatrizGiradaState) {
                      _nMatriz.value = estado.matriz;
                      _nActBtnLimpie.value = true;
                    }
                    if (estado is SerieFiboMatrizErrorState) {
                      _dialogosApp.dialogoInfo(
                          context: context,
                          titulo: "Atención",
                          mensaje:
                              "Ocurrió un error generando la serie Fibonacci, porfavor verifique el elemento inicial y final.");
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MatrizWidget(nMatriz: _nMatriz),
                      SumaMatrizWidget(
                        nMatriz: _nMatriz,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25.0, horizontal: 20.0),
                        child: Row(
                          children: [
                            const Text("Elemento inicial:"),
                            Flexible(
                              child: SizedBox(
                                height: 30.0,
                                child: TextFormField(
                                  controller: _controladorInicial,
                                  focusNode: _focoInicial,
                                  onChanged: (value) {
                                    _nMatriz.value = _matrizVacia;
                                    _nActBtnLimpie.value = false;
                                  },
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline6,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  onSaved: (newValue) {
                                    _focoInicial.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_focoFinal);
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 50.0),
                            const Text("Elemento final:"),
                            Flexible(
                              child: SizedBox(
                                height: 30.0,
                                child: TextFormField(
                                  controller: _controladorFinal,
                                  focusNode: _focoFinal,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline6,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    _nMatriz.value = _matrizVacia;
                                    _nActBtnLimpie.value = false;
                                  },
                                  onSaved: (newValue) {
                                    _focoFinal.unfocus();
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ButtonDefecto(
                          notificarBotonActivo: _nActBtnGenerar,
                          onPressed: () {
                            if (_controladorInicial.text.isNotEmpty &&
                                _controladorFinal.text.isNotEmpty) {
                              if (int.tryParse(_controladorInicial.text) !=
                                      null &&
                                  int.tryParse(_controladorFinal.text) !=
                                      null) {
                                BlocProvider.of<SerieFiboBloc>(context).add(
                                    GenerarMatrizFiboEvent(
                                        elementoInicial:
                                            int.parse(_controladorInicial.text),
                                        elementoFinal:
                                            int.parse(_controladorFinal.text)));
                                return;
                              }
                            }
                          },
                          titulo: "Generar matriz"),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Rotar:"),
                          const SizedBox(width: 20.0),
                          SizedBox(
                            width: 110.0,
                            child: IconButton(
                                color: _nActBtnLimpie.value
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                                onPressed: () {
                                  if (_nActBtnLimpie.value) {
                                    BlocProvider.of<SerieFiboBloc>(context).add(
                                        GirarMatrizFiboEvent(
                                            giroMatriz: GiroMatriz.izquierda,
                                            matriz: _nMatriz.value));
                                  }
                                },
                                icon: Row(
                                  children: const [
                                    Flexible(child: Text("Izquierda")),
                                    Icon(Icons.rotate_left),
                                  ],
                                )),
                          ),
                          const SizedBox(width: 10.0),
                          SizedBox(
                            width: 110.0,
                            child: IconButton(
                                color: _nActBtnLimpie.value
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                                onPressed: () {
                                  if (_nActBtnLimpie.value) {
                                    BlocProvider.of<SerieFiboBloc>(context).add(
                                        GirarMatrizFiboEvent(
                                            giroMatriz: GiroMatriz.derecha,
                                            matriz: _nMatriz.value));
                                  }
                                },
                                icon: Row(
                                  children: const [
                                    Flexible(child: Text("Derecha")),
                                    Icon(Icons.rotate_right),
                                  ],
                                )),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      ButtonDefecto(
                          notificarBotonActivo: _nActBtnLimpie,
                          onPressed: () {
                            _nActBtnLimpie.value = false;
                            _nMatriz.value = _matrizVacia;
                            verificarBtnGenerar();
                          },
                          titulo: "Limpiar matriz"),
                      const SizedBox(height: 20.0),
                      const Text("Candidato: Edgar Renderos")
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
