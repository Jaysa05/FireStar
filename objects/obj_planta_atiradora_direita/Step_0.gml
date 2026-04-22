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
// 2. CONTINUA O RESTO (Só se estiver viva):
event_inherited();


// Se estiver no frame 4 da animação E ainda não tiver atirado
if (floor(image_index) == 4 && !atirou) {
	// Cria a semente um pouco à frente (direita) e um pouco acima do objeto
	var _semente = instance_create_layer(x + 30, y - 15, "colisao_2", obj_semente_atiravel);
	// Define a velocidade horizontal da semente (vai para a direita)
	_semente.hspeed = 2;
	// Marca que já atirou, para não repetir no mesmo frame
	atirou = true;
}

// Se NÃO estiver no frame 4
if (floor(image_index) != 4) {
	// Reseta a variável para permitir atirar novamente
	atirou = false;
}