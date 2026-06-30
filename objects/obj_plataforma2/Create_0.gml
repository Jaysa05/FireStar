/// @description Insert description here
timer_jogador = 0;       // Timer que conta o tempo em cima
tempo_para_descer = 60;  // 60 frames = 1 segundo
velocidade_descida = 5;  // Velocidade que desce
descendo = false;        // Controla se está descendo
limite_descida = 200;    // Quantos pixels desce
yorigem = y;             // Posição Y original

// Novas variáveis para a máquina de estados e retorno automático
estado_movimento = 0;       // 0 = parado em cima, 1 = descendo, 2 = esperando embaixo, 3 = subindo
timer_espera = 0;           // Contador de tempo que fica embaixo
tempo_espera_embaixo = 120; // Tempo de espera embaixo (120 frames = 2 segundo)
