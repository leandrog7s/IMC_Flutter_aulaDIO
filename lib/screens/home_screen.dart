import 'package:flutter/material.dart';
import '../models/pessoa.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nomeController = TextEditingController();

  double peso = 70.0;
  double altura = 1.70;

  void calcularIMC() {
    String nome = nomeController.text.trim();

    if (nome.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Digite seu nome')));
      return;
    }

    Pessoa pessoa = Pessoa(nome: nome, peso: peso, altura: altura);
    double imc = pessoa.calcularIMC();
    String classificacao = pessoa.classificacaoIMC();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Resultado do IMC"),
        content: Text(
          "${pessoa.nome}, seu IMC é ${imc.toStringAsFixed(2)}\nClassificação: $classificacao",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void mostrarClassificacao() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Classificação do IMC"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Abaixo do peso: IMC < 18,5"),
            Text("• Peso normal: 18,5 – 24,9"),
            Text("• Sobrepeso: 25 – 29,9"),
            Text("• Obesidade grau I: 30 – 34,9"),
            Text("• Obesidade grau II: 35 – 39,9"),
            Text("• Obesidade grau III: ≥ 40"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculadora de IMC")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/logo.png', // coloque sua imagem em assets/logo.png
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            // Slider de Peso
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Peso: ${peso.toStringAsFixed(1)} kg"),
                Slider(
                  value: peso,
                  min: 0,
                  max: 300,
                  divisions: 600, // 300 ÷ 0.5 = 600
                  label: "${peso.toStringAsFixed(1)} kg",
                  onChanged: (value) {
                    setState(() {
                      peso = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Slider de Altura
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Altura: ${altura.toStringAsFixed(2)} m"),
                Slider(
                  value: altura,
                  min: 0,
                  max: 3,
                  divisions: 300, // 3 ÷ 0.01 = 300
                  label: "${altura.toStringAsFixed(2)} m",
                  onChanged: (value) {
                    setState(() {
                      altura = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: calcularIMC,
                  child: const Text("Calcular IMC"),
                ),
                ElevatedButton(
                  onPressed: mostrarClassificacao,
                  child: const Text("Classificação"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
