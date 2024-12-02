import 'package:flutter/material.dart';
import 'calculadora.dart';

// Função principal que inicia o aplicativo
void main() {
  runApp(const AppCalculadora());
}

// Widget principal do aplicativo
class AppCalculadora extends StatelessWidget {
  const AppCalculadora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove o banner de depuração no canto superior direito
      debugShowCheckedModeBanner: false,
      
      // Título do aplicativo
      title: 'Calculadora',
      
      // Tema do aplicativo
      theme: ThemeData(
        // Define o esquema de cores baseado no azul claro
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        // Utiliza a versão mais recente dos componentes do Material Design
        useMaterial3: true,
      ),
      
      // Define a tela inicial como `TelaInicial`
      home: const TelaInicial(titulo: 'Calculadora'),
    );
  }
}

// Widget que representa a tela inicial do aplicativo
class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key, required this.titulo});

  // Propriedade para armazenar o título da tela
  final String titulo;

  @override
  State<TelaInicial> createState() => _EstadoTelaInicial();
}

// Estado da tela inicial
class _EstadoTelaInicial extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de aplicativos na parte superior
      appBar: AppBar(
        // Cor da barra de aplicativos
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Título da barra de aplicativos
        title: Text(widget.titulo),
        // Centraliza o título
        centerTitle: true,
      ),

      // Corpo da tela
      body: Center(
        child: Column(
          // Espaçamento uniforme entre os elementos
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Área superior vazia para espaçamento
            Expanded(
              child: Container(),
            ),

            // Área central contendo a calculadora
            Expanded(
              flex: 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Espaçamento vazio à esquerda
                  Expanded(child: Container()),

                  // Caixa contendo a calculadora
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // Cor de fundo branca
                        color: Colors.white,
                        // Bordas arredondadas
                        borderRadius: BorderRadius.circular(20),
                        // Borda com cor azul claro
                        border: Border.all(
                          color: Colors.lightBlueAccent,
                          width: 2,
                        ),
                        // Sombras para criar um efeito de elevação
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      // Widget da calculadora
                      child: const Calculadora(),
                    ),
                  ),

                  // Espaçamento vazio à direita
                  Expanded(child: Container()),
                ],
              ),
            ),

            // Área inferior vazia para espaçamento
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),

      // Botão de ação flutuante no canto inferior direito
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação ao pressionar o botão (atualmente vazio)
        },
        // Dica ao passar o cursor ou tocar e segurar no botão
        tooltip: 'Incrementar',
        // Ícone do botão
        child: const Icon(Icons.add),
      ),
    );
  }
}
 