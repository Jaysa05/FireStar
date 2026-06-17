// ==============================
// CÁLCULO DE POSIÇÃO DE DESENHO (CORREÇÃO DO SENTIDO E ORIGEM 0,0 DOS SPRITES)
// ==============================
var _natural_dir = -1; // Por padrão, spr_monstro_gelo, spr_monstro_gelo_atacando e spr_monstro_gelo_andando_esquerda70 olham para a esquerda (-1)
if (sprite_index == spr_monstro_gelo_andando_direita) {
    _natural_dir = 1; // spr_monstro_gelo_andando_direita olha para a direita (1)
}

var _draw_x = x;
var _visual_scale = 1;

if (direct == _natural_dir) {
    // Já está olhando naturalmente para onde deve olhar, desenha sem alteração
    _visual_scale = 1;
    _draw_x = x;
} else {
    // Precisa inverter horizontalmente para olhar para o lado correto
    _visual_scale = -1;
    _draw_x = x + sprite_get_width(sprite_index); // Ajusta o deslocamento devido à origem (0,0)
}

// ==============================
// DESENHO DO CORPO DO BOSS
// ==============================
var _blend = make_color_rgb(140, 210, 255); // Tom azulado de monstro de gelo (Vulnerável)
if (vulneravel == false) {
    _blend = make_color_rgb(90, 110, 140); // Tom acinzentado/escuro indicando invulnerabilidade
}

if (alarm[1] > 0) {
    // Efeito de piscar branco ao receber dano (usando Fog da GPU)
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_ext(sprite_index, image_index, _draw_x + shake_x, y + y_offset, _visual_scale * scale_x_visual, scale_y_visual, 0, c_white, 1);
    gpu_set_fog(false, c_white, 0, 0);
} else {
    // Desenha o monstro
    draw_sprite_ext(sprite_index, image_index, _draw_x + shake_x, y + y_offset, _visual_scale * scale_x_visual, scale_y_visual, 0, _blend, 1);
}

// ==============================
// INDICADORES VISUAIS DOS ATAQUES
// ==============================

// 1. Indicador do SOCÃO (Telegrafa em laranja/vermelho antes de bater)
if (estado == ESTADO_MONSTRO_GELO.SOCAO) {
    var _range = 70;
    var _punch_left = (direct == 1) ? bbox_right : bbox_left - _range;
    var _punch_right = (direct == 1) ? bbox_right + _range : bbox_left;
    var _punch_top = bbox_bottom - 64; // Altura ajustada
    var _punch_bottom = bbox_bottom;
    
    if (image_index < 5) {
        // Fase de preparação (Aviso Laranja/Vermelho translúcido)
        draw_set_color(c_orange);
        draw_set_alpha(0.3);
        draw_rectangle(_punch_left, _punch_top, _punch_right, _punch_bottom, false);
        draw_set_color(c_red);
        draw_rectangle(_punch_left, _punch_top, _punch_right, _punch_bottom, true);
    } else if (image_index >= 5 && image_index <= 8) {
        // Ataque ativo (Azul/Aqua vibrante)
        draw_set_color(make_color_rgb(135, 206, 250));
        draw_set_alpha(0.65);
        draw_rectangle(_punch_left, _punch_top, _punch_right, _punch_bottom, false);
        draw_set_color(c_aqua);
        draw_rectangle(_punch_left, _punch_top, _punch_right, _punch_bottom, true);
    }
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}

// 2. Indicador da PISADA (Telegrafação retangular no solo)
if (estado == ESTADO_MONSTRO_GELO.PISADA) {
    var _monster_center = (bbox_left + bbox_right) / 2;
    var _ground_y = bbox_bottom;
    
    if (image_index < 5) {
        // Fase de elevação: Desenha área de perigo vermelha no solo (Retângulo limpo e legível)
        draw_set_color(c_red);
        draw_set_alpha(0.35);
        draw_rectangle(_monster_center - 160, _ground_y - 6, _monster_center + 160, _ground_y, false);
        draw_set_color(c_orange);
        draw_rectangle(_monster_center - 160, _ground_y - 6, _monster_center + 160, _ground_y, true);
    } else {
        // Impacto e propagação da onda ativa (desaparece gradualmente conforme se aproxima de 160)
        
		 // FASE DE IMPACTO DA PISADA
		 
		 // Nesta fase o monstro já bateu o pé no chão.
		// Agora desenhamos a onda de choque se espalhand
		
		 // Calcula a transparência da onda.
		// Quanto maior o raio da onda, mais transparente ela fica.
		var _alpha = 1.0 - (stomp_wave_radius / 160);
		
		 // Define a cor usada para desenhar a onda.
		 draw_set_color(c_aqua);
		draw_set_alpha(1.0);
	
		
		 // Aplica a transparência.
		// clamp garante que o valor fique entre 0 e 1.
		draw_set_alpha(clamp(_alpha, 0, 1));
		
		  // DESENHA A LINHA DA ONDA
		  draw_line_width(
			_monster_center - stomp_wave_radius,// início da linha (esquerda)
			_ground_y, // altura da linha
			_monster_center + stomp_wave_radius, // final da linha (direita)
			_ground_y, // mesma altura
			// espessura da linha
			3);
			
			// DESENHA OS ESPINHOS DA ONDA
			
			 // A cada 32 pixels desenhamos um par de triângulos.
			for (var _dist_onda = 32;
				 _dist_onda <= min(stomp_wave_radius,160);
				 _dist_onda += 32)
					
					// Segurança extra:
					// só desenha se a distância for até 160 pixels.
					
						
						 // ESPINHO DA ESQUERDA
						 // Desenha um triângulo apontando para cima
						// no lado esquerdo da onda.
						 draw_triangle(
			                _monster_center - _dist_onda,      // vértice inferior esquerdo
			                _ground_y,

			                _monster_center - _dist_onda - 6,  // vértice superior esquerdo
			                _ground_y - 12,

			                _monster_center - _dist_onda + 6,  // vértice superior direito
			                _ground_y - 12,

			                false
								);
								
							 // ESPINHO DA DIREITA
							  // Desenha outro triângulo simétrico
							// no lado direito da onda.
							 draw_triangle(
				                _monster_center + _dist_onda,      // vértice inferior esquerdo
				                _ground_y,

				                _monster_center + _dist_onda - 6,  // vértice superior esquerdo
				                _ground_y - 12,

				                _monster_center + _dist_onda + 6,  // vértice superior direito
				                _ground_y - 12,

				                false
				            );
						
					}
					
				}



// 3. Indicador da BRAÇADA (Telegrafação retangular)
if (estado == ESTADO_MONSTRO_GELO.BRACADA) {
    var _sweep_range = 110;
    var _sweep_left = (direct == 1) ? bbox_right : bbox_left - _sweep_range;
    var _sweep_right = (direct == 1) ? bbox_right + _sweep_range : bbox_left;
    var _sweep_top = bbox_bottom - 48; // Altura ajustada
    var _sweep_bottom = bbox_bottom;
    
    if (image_index < 6) {
        // Fase de preparação (Aviso Laranja/Vermelho rasteiro)
        draw_set_color(c_orange);
        draw_set_alpha(0.25);
        draw_rectangle(_sweep_left, _sweep_top, _sweep_right, _sweep_bottom, false);
        draw_set_color(c_red);
        draw_rectangle(_sweep_left, _sweep_top, _sweep_right, _sweep_bottom, true);
    } else if (image_index >= 6 && image_index <= 10) {
        // Ataque ativo (Vassoura de gelo verde/azul)
        draw_set_color(c_teal);
        draw_set_alpha(0.4);
        draw_rectangle(_sweep_left, _sweep_top, _sweep_right, _sweep_bottom, false);
        draw_set_color(c_aqua);
        draw_rectangle(_sweep_left, _sweep_top, _sweep_right, _sweep_bottom, true);
    }
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}

// ==============================
// BARRA DE VIDA HUD (SOBRE A CABEÇA)
// ==============================

// Só desenha a barra se o monstro ainda estiver vivo
if (vida_monstro_gelo > 0){
	
	 // Calcula a porcentagem de vida restante
    // Exemplo: 50 / 100 = 0.5 (50%)
	var _porcentagem = vida_monstro_gelo / vida_monstro_gelo_max;
	
	 // Define o tamanho da barra (80% do tamanho original)
	 var _escala = 0.8;
	 
	  // Obtém a largura da sprite da barra de vida
    // e aplica a escala definida acima
	var _largura_final = sprite_get_width(spr_chefe_hud_vida) * _escala;
	
	 // Calcula o centro horizontal do monstro
    // usando os limites esquerdo e direito da hitbox
	var _monster_center = (bbox_left + bbox_right) / 2;
	
	  // Calcula a posição X da barra
    // para que ela fique centralizada sobre o monstro
	var _x_barra = _monster_center - (_largura_final / 2);
	
	// Define a posição Y da barra
    // 20 pixels acima do topo do monstro
	var _y_barra = bbox_top - 20;
	
	// Desenha a barra de vida real
	
	// Verifica se a sprite da barra de vida existe antes de tentar desenhá-la
	if (sprite_exists(spr_chefe_hud_vida)){
		
		 // Desenha a sprite da barra de vida com configurações personalizadas
		 draw_sprite_ext(
			 // Sprite utilizada como barra de vida
			 spr_chefe_hud_vida,
			  // Frame da sprite (0 = primeiro frame)
			  0,
			   // Posição X onde a barra será desenhada
			   _x_barra,
			   // Posição Y onde a barra será desenhada
			   _y_barra,
			    // Escala horizontal da barra.
        // A porcentagem de vida restante controla o quanto a barra aparece preenchida.
        // Exemplo:
        // Vida cheia = 1.0 * 0.8 = 80% do tamanho original
				_porcentagem * _escala,
				 // Escala vertical.
        // Valor maior que 1 deixa a barra mais alta/grossa.
				1.2,
				// Rotação da sprite em graus.
        // 0 = sem rotação.
				0,
				// Cor aplicada à sprite.
        // c_white mantém as cores originais da imagem.
				c_white,
				 // Transparência (alpha).
        // 1 = totalmente visível.
				1);
	}
}
