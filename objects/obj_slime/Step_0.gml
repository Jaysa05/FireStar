/// @description Insert description here
// 1. CHECANDO A MORTE COM EXPLOSÃO NATIVA:
// 1. CHECANDO A MORTE:
// Verifica se a vida do inimigo chegou a 0 ou menos (morreu)
if (vida <= 0) {
    
    // Verifica se o alarm[1] ainda não está ativo (tempo <= 0)
    if (alarm[1] <= 0) {
        
        // Ativa o alarm[1] com 20 frames
        // Esse tempo pode ser usado para um efeito visual (ex: flash branco)
        alarm[1] = 20; 
    }
	
	image_speed = 3; // quanto maior, mais rápido
    
    // Executa o código do objeto pai
    // (normalmente usado para lidar com a morte, como virar fumaça ou destruir)
    event_inherited(); 
    
    // Interrompe o restante do código deste evento
    // Evita que outras ações sejam executadas após a morte
    exit;
}

event_inherited(); 
// 1. Caminha SOMENTE para o lado esquerdo eternamente
x = x - 1;// Velocidade da caminhada
image_xscale = 1; // Vira o rostinho para a esquerda
// 2. O Sensor de Borda do Mapa
// Quando o X do slime for menor que 0 (Saiu da tela pela esquerda)
if(x < - 25) {
	// TELEPORTE! Traz o slime instantaneamente para as coordenadas do começo
	x = ponto_de_partida
}


