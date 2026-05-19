limite_y = 30;

// Define o estado inicial do objeto.
// 1 indica que ele já começa no estado de "descendo".
estado = 1;

timer = 0;

// Variável booleana (verdadeiro/falso).
// Aqui serve como um "controle" para evitar que o evento Create
// reinicie ou sobrescreva o estado atual do objeto.
// Ou seja, garante que esse estado (descendo) seja mantido.
iniciado = true;