if hit == true {
    veloc = 0;
    alarm[1] = 5;     // Inicia um timer de 5 frames (geralmente usado para efeitos de hit, como piscar ou recuo)
    hit = false;      // Reseta o flag de hit, para não entrar nesse bloco novamente até receber outro dano
}

if vida <= 0 {
    if reset == false {
        image_index = 0; 
        reset = true;    
    }

    sprite_index = sprite_morrendo; 
    
    // O SEGREDO ESTÁ AQUI: Quando a fumaça da morte termina!
    if scr_fim_da_animacao(){
        
    // ==============================
// SISTEMA DE DROP DE ITENS
// ==============================

if (item_drop != noone){
	
    // de acordo com a quantidade definida
	for (var i = 0; i < item_drop_quantidade; i ++){
		
		var _x_drop = x + random_range(-25, 25);
		
        // com uma pequena variação aleatória
		var _y_drop = (y - 25) + random_range(-10, 0);
		
		 // ==============================
        // SISTEMA DE SEGURANÇA CONTRA PAREDES
        // ==============================
		
		 if (position_meeting(_x_drop, _y_drop, obj_parede)){
			 
            // para mais perto do centro do inimigo (lugar seguro)
			_x_drop = x + random_range(-5, 5);
			_y_drop = y -25;
			
			
		 }
		
		// Cria o item no jogo na posição calculada
        // "colisao" é a layer onde o item será colocado
		instance_create_layer(_x_drop, _y_drop, "colisao", item_drop);
	}
}

// ==============================
// REMOÇÃO DO INIMIGO
// ==============================

// Depois de dropar os itens, remove o inimigo do jogo
instance_destroy()

	}
}
