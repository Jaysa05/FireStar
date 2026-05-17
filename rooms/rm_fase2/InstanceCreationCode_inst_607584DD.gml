limite_y = 30;

// 3 significa que ele já começa no estado de "subindo".
estado = 3;

// ystart é a posição onde o objeto foi criado.
// Somando limite_y (60), o objeto começa mais embaixo.
y = ystart + limite_y;

// Inicializa o contador de tempo.
timer = 0;

// Variável booleana (verdadeiro/falso).
// Indica que o objeto já foi iniciado e pode executar sua lógica normalmente.
iniciado = true;