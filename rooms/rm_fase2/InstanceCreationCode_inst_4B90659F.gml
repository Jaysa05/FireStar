limite_y = 30; 
// Define o limite de movimento no eixo Y (vertical).
// O objeto poderá se mover até 60 pixels para baixo.

estado = 0; 
// Define o estado inicial do objeto.
// 0 significa que ele está parado em cima, esperando.

timer = 45; 
// Define um contador de tempo.
// Começa em 45 para não iniciar do zero, criando um atraso (defasagem).
// Isso evita que vários objetos façam a mesma coisa ao mesmo tempo.

iniciado = true; 
// Variável booleana (verdadeiro/falso).
// Indica que o objeto já foi iniciado e pode começar a executar sua lógica.