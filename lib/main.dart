import 'package:fibonacci/domain/serie_fibo_bloc/serie_fibo_bloc.dart';
import 'package:fibonacci/presentation/utils/datos_tema.dart';
import 'package:fibonacci/presentation/views/splash_view.dart';
import 'package:fibonacci/presentation/widgets/base/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(ThemeSwitcherWidget(
      initialTheme: DatosTemas.modoClaro, child: const FiboDimensionalApp()));
}

class FiboDimensionalApp extends StatelessWidget {
  const FiboDimensionalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => SerieFiboBloc())],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: MaterialApp(
          title: 'Fibonacci Dimensional',
          themeMode: ThemeMode.system,
          theme: ThemeSwitcher.of(context).themeData,
          darkTheme: DatosTemas.modoOscuro,
          home: MultiBlocProvider(
              providers: [BlocProvider(create: (context) => SerieFiboBloc())],
              child: const SplashView()),
        ),
      ),
    );
  }
}
