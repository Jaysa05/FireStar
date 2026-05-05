/// @description Insert description here
// 1. Mantém o efeito de piscar ao tomar dano (herdado do comportamento do pai)
if (alarm[1] > 0) {
    gpu_set_fog(true, c_white, 0, 0);
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_self();
}

// Só desenha a barra se o boss estiver vivo e não estiver no estado de morte
if (vida_boss > 0 && estado != ESTADO_BOSS.MORTE) {
	
	 // Calcula a porcentagem de vida do boss (valor entre 0 e 1)
    // Ex: 50/100 = 0.5 (metade da vida)
	var _porcentagem = vida_boss / vida_boss_max;
	
	 // Define a escala (tamanho) da barra
    // 0.8 = 80% do tamanho original
	var _escala = 0.8;
	
	 // Calcula a largura final da barra com base na sprite original (128px)
    // Multiplica pela escala para reduzir o tamanho
	var _largura_final = 128 * _escala;
	
	 // Calcula a posição X da barra
    // Subtrai metade da largura para centralizar no boss
	var _x_barra = x - (_largura_final /2);
	
	 // Calcula a posição Y da barra
    // Coloca a barra acima do boss (100 pixels acima)
	var _y_barra = y - 100;
	
	 // Desenha a barra de vida
	 draw_sprite_ext(
	  spr_chefe_hud_vida,        // Sprite da barra de vida
        0,                         // Frame da sprite (0 = primeiro frame)
        _x_barra,                  // Posição horizontal (centralizada)
        _y_barra,                  // Posição vertical (acima do boss)
        
        // Escala horizontal:
        // _porcentagem faz a barra diminuir conforme perde vida
        // _escala mantém o tamanho proporcional
        _porcentagem * _escala,
        
        1.2,                       // Escala vertical (altura da barra, deixa mais grossa)
        0,                         // Rotação (0 = normal, sem girar)
        c_white,                   // Cor (branco = sem alteração)
        1                          // Opacidade (1 = totalmente visível)
    );
}
	 
	
	 
	 
	 
	 
	 
	 
	 

