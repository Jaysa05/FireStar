limite_y = 30;

// Define o estado inicial do objeto.
// 3 significa que ele já começa no estado de "subindo".
estado = 3;

// Define a posição vertical inicial do objeto.
// ystart é a posição onde o objeto foi criado.
// Somando limite_y (60), o objeto começa mais embaixo.
// Ou seja, ele inicia na parte inferior do movimento.
y = ystart + limite_y;

// Inicializa o contador de tempo.
// Começa do zero, indicando que o ciclo de tempo está começando agora.
timer = 0;

// Variável booleana (verdadeiro/falso).
// Indica que o objeto já foi iniciado e pode executar sua lógica normalmente.
iniciado = true;