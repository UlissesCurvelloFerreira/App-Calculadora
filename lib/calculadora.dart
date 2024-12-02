import 'package:expressions/expressions.dart'; // Importa uma biblioteca para avaliar expressões matemáticas.
import 'package:flutter/material.dart'; // Importa o Flutter para criar a interface gráfica.

class Calculadora extends StatefulWidget {
  const Calculadora({super.key}); // Construtor da calculadora.

  @override
  State<Calculadora> createState() => _EstadoCalculadora(); // Define o estado associado ao widget Calculadora.
}

class _EstadoCalculadora extends State<Calculadora> {
  // Constante para o botão de limpar.
  final String _limpar = 'Limpar'; 

  // Variável para armazenar a expressão digitada pelo usuário.
  String _expressao = '';

  // Variável para armazenar o resultado do cálculo.
  String _resultado = '';

  // Método chamado ao pressionar um botão.
  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        // Limpa a expressão e o resultado se o botão de limpar for pressionado.
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        // Calcula o resultado se o botão "=" for pressionado.
        _calcularResultado();
      } else {
        // Adiciona o valor pressionado à expressão.
        _expressao += valor;
      }
    });
  }

  // Método para calcular o resultado da expressão.
  void _calcularResultado() {
    try {
      // Avalia a expressão e converte o resultado em uma string.
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      // Exibe uma mensagem de erro caso a avaliação falhe.
      _resultado = 'Erro de cálculo!';
    }
  }

  // Método para avaliar a expressão matemática.
  double _avaliarExpressao(String expressao) {
    // Substitui os símbolos de multiplicação, divisão e porcentagem.
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    expressao = expressao.replaceAll('%', '/100');
    
    // Substitui expressões de raiz quadrada pela operação correspondente.
    expressao = expressao.replaceAllMapped(
      RegExp(r'√(\d+(\.\d+)?)'), // Captura números após o símbolo "√".
      (match) => '(${double.parse(match[1]!).toString()}^(1/2))', // Representa como potência de 1/2.
    );

    // Avalia a expressão usando o ExpressionEvaluator.
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }

  // Método para criar botões da calculadora.
  Widget _botao(String valor) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16), // Define o espaçamento interno do botão.
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Define cantos arredondados.
        backgroundColor: valor == '='
            ? Colors.lightGreen[300] // Define a cor verde claro para o botão "=".
            : Colors.lightBlue[100], // Define a cor azul claro para outros botões.
      ),
      child: Text(
        valor, // Exibe o valor do botão.
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), // Estilo do texto.
      ),
      onPressed: () => _pressionarBotao(valor), // Chama o método ao pressionar o botão.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          // Exibe a expressão na parte superior.
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(
              _expressao,
              style: const TextStyle(fontSize: 24), // Estilo do texto da expressão.
            ),
          ),
        ),
        Expanded(
          // Exibe o resultado abaixo da expressão.
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(
              _resultado,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Estilo do texto do resultado.
            ),
          ),
        ),
        Expanded(
          flex: 3, // Aumenta a área para os botões da calculadora.
          child: GridView.count(
            crossAxisCount: 4, // Organiza os botões em 4 colunas.
            childAspectRatio: MediaQuery.of(context).size.aspectRatio * 1.5, // Ajusta a proporção dos botões.
            padding: const EdgeInsets.all(8), // Espaçamento ao redor dos botões.
            children: [
              // Criação dos botões numéricos e de operações.
              _botao('7'),
              _botao('8'),
              _botao('9'),
              _botao('÷'),
              _botao('4'),
              _botao('5'),
              _botao('6'),
              _botao('x'),
              _botao('1'),
              _botao('2'),
              _botao('3'),
              _botao('-'),
              _botao('0'),
              _botao('.'),
              _botao('='), // Botão de "=" destacado.
              _botao('+'),
            ],
          ),
        ),
        // Botão de limpar exibido separadamente.
        Padding(
          padding: const EdgeInsets.all(8.0), // Espaçamento ao redor do botão.
          child: _botao(_limpar),
        ),
      ],
    );
  }
}
