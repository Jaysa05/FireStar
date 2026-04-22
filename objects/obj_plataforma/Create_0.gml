/// @description Insert description here
tempo_espera = 90; // Tempo que ela fica parada (1,5 segundos no caso)
velocidade = 4;// Velocidade da rotação (maior = mais rápido)
vire = true;// Mudar para false se quiser que ele fique parado
atraso_inicial = 0;

// --- Controle Interno ---//
 // Inicia no estado de atraso
estado = -1;// 0: Horizontal, 1: Girando p/ Lado, 2: De Lado, 3: Voltando
timer = 0;// Cria um contador de tempo (timer)
// Começa em 0 e vai aumentando ao longo do tempo
// Usado para controlar quando o objeto deve mudar de estado

