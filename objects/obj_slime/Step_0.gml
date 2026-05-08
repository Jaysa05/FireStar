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

// ------------------------------
// 1. Lógica de movimento e desaparecimento
// ------------------------------

// Verifica se o slime está visível (aparecido na tela)
if(estado_visivel){
	
	 // Move o slime para a esquerda
	 x = x - velocidade_slime;
	 
	  // Verifica se ele saiu totalmente da tela pela esquerda
	  if (x < -50){
		  
		   // Define que ele não está mais visível
		   estado_visivel = false;
		   
		   // Esconde o slime da tela
		   visible = false;
		   
		   // Remove a colisão (fica intangível, como um fantasma)
		   mask_index = -1;
		   
		    // Inicia o tempo que ele ficará invisível (ex: 10 segundos)
			timer_slime = tempo_invisivel;
			
			
	  }
} else {
	
	 // ------------------------------
    // 2. Lógica enquanto está invisível
    // ------------------------------
	
	// Diminui o timer a cada frame (contador regressivo)
	timer_slime -= 1;
	
	// Quando o tempo de invisível acaba
	if (timer_slime <= 0){
		
		 // ------------------------------
        // 3. Definir onde ele vai reaparecer
        // ------------------------------
		
		 // Verifica se existe o objeto "girador" na fase
		 if (instance_exists(obj_girador)){
			 
			  // Teleporta o slime para perto do girador
			  x = obj_girador.x - 40;
			  
		 }	else{
			 
			  // Se não existir girador, usa uma posição padrão
			  x = 130;
		 }
		 
		  // ------------------------------
        // 4. Faz o slime reaparecer
        // ------------------------------
		
		// Define que ele está visível novamente
		estado_visivel = true;
		
		 // Mostra o slime na tela
		 visible = true;
		 
		  // Restaura a colisão normal do slime
		  mask_index = spr_slime;

	}
	
}

// ------------------------------
// 5. Direção do sprite
// ------------------------------

// Mantém o slime virado para um lado (depende do sprite)
image_xscale = 1;
