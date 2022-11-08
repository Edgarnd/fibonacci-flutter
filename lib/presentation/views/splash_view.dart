import 'package:fibonacci/presentation/views/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void iniciarPantalla() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    Future.delayed(const Duration(seconds: 3)).whenComplete(() =>
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (context) => const HomeView()),
            (route) => false));
  }

  @override
  void initState() {
    SchedulerBinding.instance
        .addPostFrameCallback((timeStamp) => iniciarPantalla());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/fibo_logo.png",
          scale: 1.25,
        ),
      ),
    );
  }
}
