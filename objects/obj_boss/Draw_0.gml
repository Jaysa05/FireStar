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
	
    // Ex: 50/100 = 0.5 (metade da vida)
	var _porcentagem = vida_boss / vida_boss_max;
	
    // 0.8 = 80% do tamanho original
	var _escala = 0.8;
	
    // Multiplica pela escala para reduzir o tamanho
	var _largura_final = 128 * _escala;
	
	var _x_barra = x - (_largura_final /2);
	
    // Coloca a barra acima do boss (100 pixels acima)
	var _y_barra = y - 100;
	
	 // Desenha a barra de vida
	 draw_sprite_ext(
	  spr_chefe_hud_vida,
        0,
        _x_barra,
        _y_barra,
        
        // Escala horizontal:
        // _porcentagem faz a barra diminuir conforme perde vida
        // _escala mantém o tamanho proporcional
        _porcentagem * _escala,
        
        1.2,
        0,
        c_white,
        1
    );
}
	 
	
	 
	 
	 
	 
	 
	 
	 

