/// @description Insert description here
// Verifica se o inimigo acabou de sofrer um golpe
if hit == true {
    veloc = 0;        // Para o movimento horizontal temporariamente (fica “congelado”)
    alarm[1] = 20;     // Inicia um timer de 20 frames para o inimigo piscar branco (Dura mais tempo para o jogador poder ver!)
    hit = false;      // Reseta o flag de hit, para não entrar nesse bloco novamente até receber outro dano
}

// Verifica se a vida do personagem/inimigo chegou a zero
// Verifica se a vida chegou a zero
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

// Verifica se existe um item para dropar (se não for "nenhum")
if (item_drop != noone){
	
	 // Repete o processo de criação de itens
    // de acordo com a quantidade definida
	for (var i = 0; i < item_drop_quantidade; i ++){
		
		// Define uma posição X aleatória próxima ao inimigo
		var _x_drop = x + random_range(-25, 25);
		
		 // Define uma posição Y um pouco acima do inimigo,
        // com uma pequena variação aleatória
		var _y_drop = (y - 25) + random_range(-10, 0);
		
		 // ==============================
        // SISTEMA DE SEGURANÇA CONTRA PAREDES
        // ==============================
		
		 // Verifica se o ponto gerado está dentro de uma parede
		 if (position_meeting(_x_drop, _y_drop, obj_parede)){
			 
			 // Se estiver dentro da parede, ajusta a posição
            // para mais perto do centro do inimigo (lugar seguro)
			_x_drop = x + random_range(-5, 5);
			_y_drop = y -25;
			
			
		 }
		
		// Cria o item no jogo na posição calculada
        // Usamos depth para nunca dar erro de layer não encontrada em outras fases!
		instance_create_depth(_x_drop, _y_drop, depth, item_drop);
	}
}

// ==============================
// REMOÇÃO DO INIMIGO
// ==============================

// Depois de dropar os itens, remove o inimigo do jogo
instance_destroy()

	}
}

// Ajusta a profundidade (depth) dinamicamente para que o inimigo apareça na frente do fundo e dos tiles,
// e se alinhe corretamente com o jogador (Y-sorting).
depth = -bbox_bottom;

