/// @description Desenha o Minotauro corrigindo o flip de origem

// Escala horizontal usada para desenhar o sprite.
// 1 = normal | -1 = espelhado (virado)
var _draw_xscale = 1;

// Posição X e Y onde o sprite será desenhado
var _draw_x = x;
var _draw_y = y;

// Verifica se existe um sprite válido para ser desenhado
if (sprite_exists(sprite_index)){
	 
	// Obtém a largura do sprite atual
	var _width = sprite_get_width(sprite_index);
	 
	var _sprite_nativo_esquerda =
		(sprite_index == spr_minotauro_andando_esquerda ||
		 sprite_index == spr_investida_cortante_minotauro ||
		 sprite_index == spr_machadada);
		 
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
			_draw_xscale = -1;
			
			// Corrige a posição após o espelhamento
			// para manter o alinhamento com a colisão
			_draw_x = x + _width;
		}
	}
	
	// Correção de offset visual para spr_machadada (evita o pulo e alinha o pé com o chão)
	if (sprite_index == spr_machadada) {
		_draw_y -= 10; // Alinha os pés verticalmente com o idle (retirando o pé de dentro do chão)
	}
}
    
// ====================================================
// EFEITO VISUAL DE DANO (PISCAR EM BRANCO)
// ====================================================

// Verifica se o alarme do efeito de dano ainda está ativo.
if (alarm[1] > 0){
	
	// Ativa um efeito de brilho/filtro branco no desenho.
	gpu_set_fog(true, c_white, 0 , 0)
	
	// Desenha o sprite do personagem com todas as configurações atuais
	draw_sprite_ext(
		sprite_index,
		image_index,
		_draw_x,
		_draw_y,
		_draw_xscale,
		image_yscale,
		image_angle,
		image_blend,
		image_alpha
	);
	
	// Desliga o efeito branco depois de desenhar.
	gpu_set_fog(false, c_white, 0 ,0);
	
}

else {
	
	// Caso o personagem não esteja sofrendo o efeito de dano, desenha normalmente
	draw_sprite_ext(
		sprite_index,
		image_index,
		_draw_x,
		_draw_y,
		_draw_xscale,
		image_yscale,
		image_angle,
		image_blend,
		image_alpha
	);
}
