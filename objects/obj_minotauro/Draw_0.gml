/// @description Desenha o Minotauro corrigindo o flip de origem

// Escala horizontal usada para desenhar o sprite.
    // 1 = normal | -1 = espelhado (virado)
	var _draw_xscale = 1;
	
	 // Posição X onde o sprite será desenhado
	 var _draw_x = x;

// Verifica se existe um sprite válido para ser desenhado
if (sprite_exists(sprite_index)){
	 
	 // Obtém a largura do sprite atual
	 var _width = sprite_get_width(sprite_index);
	 
	   // Verifica se o sprite atual foi desenhado originalmente
    // olhando para a ESQUERDA
		 var _sprite_nativo_esquerda =
        (sprite_index == spr_minotauro_andando_esquerda ||
         sprite_index == spr_investida_cortante_minotauro);
		 
		  // ----------------------------------------------------
		 // SPRITES NATIVOS DE ESQUERDA
		// ----------------------------------------------------
		
		if (_sprite_nativo_esquerda) {
			
			 // Se o minotauro deve olhar para a direita,
			// precisamos espelhar o sprite
			if (direct == 1) {
				
				// Inverte horizontalmente a imagem
				_draw_xscale = -1;
				
				  // Corrige a posição após o espelhamento
				 // para manter o alinhamento com a colisão
				 _draw_x = x + _width;
			}
		}
		
 // ----------------------------------------------------
    // SPRITES NATIVOS DE DIREITA
    // ----------------------------------------------------
	else {
		
		// Se o minotauro deve olhar para a esquerda,
        // precisamos espelhar o sprite
		if (direct == -1) {
			
			// Inverte horizontalmente a imagem
			_draw_xscale = - 1;
			
			 // Corrige a posição após o espelhamento
            // para manter o alinhamento com a colisão
			_draw_x = x + _width;
		}
	}
	
}
    
 // ====================================================
// EFEITO VISUAL DE DANO (PISCAR EM BRANCO)
// ====================================================

// Verifica se o alarme do efeito de dano ainda está ativo.
// Enquanto alarm[1] for maior que 0, significa que o personagem
// ainda está no tempo de piscar após receber dano.
if (alarm[1] > 0){
	
	// Ativa um efeito de brilho/filtro branco no desenho.
    // Isso faz o sprite parecer que está piscando ao levar dano.
	gpu_set_fog(true, c_white, 0 , 0)
	
	// Desenha o sprite do personagem com todas as configurações atuais:
    // - sprite_index = qual imagem usar
    // - image_index = qual frame da animação mostrar
    // - _draw_x e y = posição na tela
    // - _draw_xscale = direção do sprite (normal ou invertido)
    // - image_yscale = tamanho vertical
    // - image_angle = rotação
    // - image_blend = cor do sprite
    // - image_alpha = transparência
    draw_sprite_ext(
        sprite_index,
        image_index,
        _draw_x,
        y,
        _draw_xscale,
        image_yscale,
        image_angle,
        image_blend,
        image_alpha
    );
	
	// Desliga o efeito branco depois de desenhar.
    // Isso evita que outros objetos do jogo fiquem brancos também.
	gpu_set_fog(false, c_white, 0 ,0);
	
}

else {
	
	 // Caso o personagem não esteja sofrendo o efeito de dano,
    // apenas desenha o sprite normalmente sem o brilho branco.
    draw_sprite_ext(
        sprite_index,
        image_index,
        _draw_x,
        y,
        _draw_xscale,
        image_yscale,
        image_angle,
        image_blend,
        image_alpha
    );
}

