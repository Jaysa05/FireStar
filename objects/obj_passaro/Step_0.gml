
depth = -10;
// 1. CHECANDO A MORTE COM EXPLOSÃO NATIVA:
// 1. CHECANDO A MORTE:
if (vida <= 0) {
    
    if (alarm[1] <= 0) {
        
        // Ativa o alarm[1] com 20 frames
        // Esse tempo pode ser usado para um efeito visual (ex: flash branco)
        alarm[1] = 20; 
    }
	
	image_speed = 3;
    
    // (normalmente usado para lidar com a morte, como virar fumaça ou destruir)
    event_inherited(); 
    
    exit;
}

event_inherited();

// === MOVIMENTO DO PÁSSARO ===

// === MOVIMENTO DO PÁSSARO ===
x += hveloc;
// "x" é a posição horizontal
// "hveloc" é a velocidade horizontal
// Ex: se hveloc = 3 → vai pra direita
//     se hveloc = -3 → vai pra esquerda

// Limite DIREITO: inverte para a esquerda
if ( x >= 460){ // Se o pássaro chegou ou passou do limite direito (posição 460)
	x = 460;
	
	// abs(hveloc) pega o valor positivo da velocidade
    // o "-" na frente deixa negativo
    // Resultado: força o movimento para a esquerda
	hveloc = -abs(hveloc);
	
	image_xscale = 1
    // Aqui estou dizendo que o pássaro está virado para a esquerda
}
	
	
	
// Limite ESQUERDO: inverte para a direita
if ( x <= 300){
	x = 300;
	
	 // abs(hveloc) garante que o valor seja positivo
    // Resultado: movimento para a direita
	hveloc = abs(hveloc)
	
	// Inverte o sprite (espelha horizontalmente)
    // Aqui você está dizendo que o pássaro está virado para a direita
	image_xscale = -1;
	
}

// === MERGULHO DO PÁSSARO ===

if(!mergulhando && !voltando){
	
	if ( instance_exists(obj_personagem)){
		
        // 1) Se o jogador está perto no eixo X (menos de 60 pixels)
        // 2) Se o jogador está embaixo do pássaro (y maior)
		if(abs(obj_personagem.x - x) < 60 && obj_personagem.y > y){
			
			mergulhando = true;
		}
	}
}

else if (mergulhando){
	
	y += 2;
	
	if (y >= y_inicial + 45){
		
		 // Para de mergulhar
		 mergulhando = false;
		 
		 voltando = true;
	}
}

else if (voltando){
	
	y -= 2;
	
	if (y <= y_inicial){
		
		// Corrige exatamente a posição inicial
		y = y_inicial;
		
		// Para de subir
		voltando = false;
	}
}