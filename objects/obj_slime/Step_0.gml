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

// ------------------------------
// 1. Lógica de movimento e desaparecimento
// ------------------------------

if(estado_visivel){
	
	 x = x - velocidade_slime;
	 
	  if (x < -50){
		  
		   estado_visivel = false;
		   
		   // Esconde o slime da tela
		   visible = false;
		   
		   // Remove a colisão (fica intangível, como um fantasma)
		   mask_index = -1;
		   
			timer_slime = tempo_invisivel;
			
			
	  }
} else {
	
	 // ------------------------------
    // 2. Lógica enquanto está invisível
    // ------------------------------
	
	timer_slime -= 1;
	
	if (timer_slime <= 0){
		
		 // ------------------------------
        // 3. Definir onde ele vai reaparecer
        // ------------------------------
		
		 if (instance_exists(obj_girador)){
			 
			  // Teleporta o slime para perto do girador
			  x = obj_girador.x - 40;
			  
		 }	else{
			 
			  x = 130;
		 }
		 
		  // ------------------------------
        // 4. Faz o slime reaparecer
        // ------------------------------
		
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
