import 'dart:convert';

Matriz3X3 matriz3X3FromJson(String str) => Matriz3X3.fromJson(json.decode(str));

String matriz3X3ToJson(Matriz3X3 data) => json.encode(data.toJson());

class Matriz3X3 {
  Matriz3X3({
    required this.fila1,
    required this.fila2,
    required this.fila3,
  });

  List<int> fila1;
  List<int> fila2;
  List<int> fila3;

  factory Matriz3X3.fromJson(Map<String, dynamic> json) => Matriz3X3(
        fila1: List<int>.from(json["fila1"].map((x) => x)),
        fila2: List<int>.from(json["fila2"].map((x) => x)),
        fila3: List<int>.from(json["fila3"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "fila1": List<dynamic>.from(fila1.map((x) => x)),
        "fila2": List<dynamic>.from(fila2.map((x) => x)),
        "fila3": List<dynamic>.from(fila3.map((x) => x)),
      };
}
