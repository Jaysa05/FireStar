/// @description Step do pássaro
depth = -10;
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


// === MOVIMENTO DO PÁSSARO ===

// === MOVIMENTO DO PÁSSARO ===
// Move o pássaro na horizontal
x += hveloc;
// "x" é a posição horizontal
// "hveloc" é a velocidade horizontal
// Ex: se hveloc = 3 → vai pra direita
//     se hveloc = -3 → vai pra esquerda

// Limite DIREITO: inverte para a esquerda
if ( x >= 460){ // Se o pássaro chegou ou passou do limite direito (posição 460)
	// Trava ele exatamente no limite (impede de passar)
	x = 460;
	
	// abs(hveloc) pega o valor positivo da velocidade
    // o "-" na frente deixa negativo
    // Resultado: força o movimento para a esquerda
	hveloc = -abs(hveloc);
	
	image_xscale = 1
	 // Define o sprite "normal"
    // Aqui estou dizendo que o pássaro está virado para a esquerda
}
	
	
	
	// Limite ESQUERDO: inverte para a direita
// Se o pássaro chegou ou passou do limite esquerdo (posição 300)	
if ( x <= 300){
	// Trava ele exatamente no limite (impede de passar)
	x = 300;
	
	 // abs(hveloc) garante que o valor seja positivo
    // Resultado: movimento para a direita
	hveloc = abs(hveloc)
	
	// Inverte o sprite (espelha horizontalmente)
    // Aqui você está dizendo que o pássaro está virado para a direita
	image_xscale = -1;
	
}
	

